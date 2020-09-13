require 'discordrb'
require 'dotenv/load'
require_relative 'Handler'
require_relative 'overrides/command_bot.rb'

module FibyBot
  BOT = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: 'rb ', fancy_log: true)

  # Load our commands and events
  FibyBot.load_modules(:Commands, 'commands')
  FibyBot.load_modules(:Events, 'events')

  BOT.run()
end