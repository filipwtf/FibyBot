module FibyBot
  module Commands
    class Purge extend Discordrb::Commands::CommandContainer
      command :purge do |event, amount|
        break unless event.user.id == 451124287244468226
        
        m.delete
        amount = amount.to_i
        return "You can only delete between 1 and 100 messages!" if amount > 100
        event.channel.prune amount, true
        m = event.respond "Done purging #{amount} messages 💥"
        sleep 2
        m.delete
      end
    end
  end
end