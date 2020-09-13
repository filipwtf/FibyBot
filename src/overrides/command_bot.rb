require 'async'

module Discordrb::Commands
  def execute_command(name, event, arguments, chained = false, check_permissions = true)
    Async do |task|
      debug("Executing command #{name} with arguments #{arguments}")
      return unless @commands
  
      command = @commands[name]
      command = command.aliased_command if command.is_a?(CommandAlias)
      return unless !check_permissions || channels?(event.channel, @attributes[:channels]) ||
                    (command && !command.attributes[:channels].nil?)
  
      unless command
        event.respond @attributes[:command_doesnt_exist_message].gsub('%command%', name.to_s) if @attributes[:command_doesnt_exist_message]
        return
      end
      return unless !check_permissions || channels?(event.channel, command.attributes[:channels])
  
      arguments = arg_check(arguments, command.attributes[:arg_types], event.server) if check_permissions
      if (check_permissions &&
         permission?(event.author, command.attributes[:permission_level], event.server) &&
         required_permissions?(event.author, command.attributes[:required_permissions], event.channel) &&
         required_roles?(event.author, command.attributes[:required_roles]) &&
         allowed_roles?(event.author, command.attributes[:allowed_roles])) ||
         !check_permissions
        event.command = command
        result = command.call(event, arguments, chained, check_permissions)
        stringify(result)
      else
        event.respond command.attributes[:permission_message].gsub('%name%', name.to_s) if command.attributes[:permission_message]
        nil
      end
    rescue Discordrb::Errors::NoPermission
      event.respond @attributes[:no_permission_message] unless @attributes[:no_permission_message].nil?
      raise
    end
  end
end