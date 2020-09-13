module FibyBot
  module Commands
    class Restart extend Discordrb::Commands::CommandContainer
      command :restart  do |event|
        break unless event.user.id == 451124287244468226 
        
        FibyBot::BOT.send_message(event.channel.id, 'Bot is restarting')
        FibyBot::BOT.stop
        
        FibyBot.restart
      end
    end
  end
end