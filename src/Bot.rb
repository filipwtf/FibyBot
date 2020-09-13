require 'discordrb'
require 'dotenv/load'
require_relative 'Commands'
require_relative 'Events'
require_relative 'overrides/command_bot.rb'

module FibyBot
  BOT = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: 'rb ', fancy_log: true)
  FibyBot.load_commands
  FibyBot.load_events
  
  BOT.run()
end