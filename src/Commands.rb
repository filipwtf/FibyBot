module FibyBot
  module Commands
    def load_commands
      commands = Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| load file }
      
      commands.map! do |command|
        command.split('commands/')[1].split('.rb')[0]
      end

      commands.each do |command|
        symbol_to_class = FibyBot.const_get("#{:Commands}::#{command}")
        FibyBot::BOT.include!(symbol_to_class)
      end
    end
  end
  FibyBot.extend Commands
end