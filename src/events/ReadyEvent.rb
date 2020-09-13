module FibyBot
  module Events
    class ReadyEvent extend Discordrb::EventContainer
      ready do |event|
        FibyBot::BOT.update_status 'online', '😍 @riz_xtar', nil, 0, false, 3
      end
    end
  end
end