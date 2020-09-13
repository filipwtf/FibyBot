module FibyBot
  module Commands
    class Shutdown extend Discordrb::Commands::CommandContainer
      command :shutdown  do |event|
        break unless event.user.id == 451124287244468226 
        
        FibyBot::Bot.send_message(event.channel.id, 'Bot is shutting down')
        FibyBot::Bot.stop
        exit
      end
    end
  end
end