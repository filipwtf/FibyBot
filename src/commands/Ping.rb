module FibyBot
  module Commands
    class Ping extend Discordrb::Commands::CommandContainer
      command :ping do |event|
          event.respond("Pong! Bot response time: #{Time.now - event.timestamp}s")
      end
    end
  end
end