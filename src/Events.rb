require 'async'
module FibyBot
  module Events
    def load_events
      events = Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| load file }
      
      events.map! do |event|
        event.split('events/')[1].split('.rb')[0]
      end

      events.each do |event|
        Async do |task|
          symbol_to_class = FibyBot.const_get("#{:Events}::#{event}")
          FibyBot::BOT.include!(symbol_to_class)
        end
      end
    end
  end
  FibyBot.extend Events
end