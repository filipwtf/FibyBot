module FibyBot
  module Commands
    class Shutdown extend Discordrb::Commands::CommandContainer
      command :shutdown  do |event|
        break unless event.user.id == 451124287244468226 
        
        FibyBot::BOT.send_message(event.channel.id, 'Bot is shutting down')
        FibyBot::BOT.stop
        exit
      end
    end
  end
end