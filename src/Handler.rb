require 'async'

module FibyBot
  module Handler
    def load_modules(clazz, path)
      modules = Dir["#{File.dirname(__FILE__)}/#{path}/*.rb"].each { |file| load file }
      
      modules.map! do |mod|
        mod.split("#{path}/")[1].split('.rb')[0]
      end

      modules.each do |mod|
        Async do
          symbol_to_class = FibyBot.const_get("#{clazz}::#{mod}")
          FibyBot::BOT.include!(symbol_to_class)
        end
      end
    end

  def restart
    exec "bundle exec ruby #{File.dirname(__FILE__)}/Bot.rb"
  end

  end
  FibyBot.extend Handler
end