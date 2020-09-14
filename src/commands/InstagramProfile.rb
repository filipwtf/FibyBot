
require_relative '../utils/Parser'

module FibyBot
  module Commands
    class InstagramProfile extend Discordrb::Commands::CommandContainer
      command :igp do |event|
        message = event.content.split('igp ')[1]
        if message.match(/(?:(https|http):\/\/)?(?:w{3}\.)?(instagram.com\/)(.*)/)
          event.message.delete
          name, stats, image = Parser::ProfileParser.parse(message)

          event.channel.send_embed do |embed|
            embed.title = "FibyBot IG Profile Stats"
            embed.colour = 0x5a60e8
            embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: image)
            embed.description = "#{name} Profile stats"
            embed.add_field(name: "Stats", value: stats)
          end
        elsif message.match(/(?:@)?(\w*.*)/)
        
        else
          event.respond('Not an instagram profile')
        end
      end
    end
  end
end