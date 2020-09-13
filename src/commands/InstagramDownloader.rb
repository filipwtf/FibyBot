require_relative '../utils/Parser'

module FibyBot
  module Commands
    class InstagramDownloader extend Discordrb::Commands::CommandContainer
      command :igd do |event|
        message = event.content.split('igd ')[1]
        if message.match(/(http[s])(:\/\/)([w]{3})([.])(instagram.com\/)([p]?[reel]*\/)(.*)/)
          event.message.delete
          url, thumbnail, title = Parser.parse(message)
          thumbnail = thumbnail.nil? ? url : thumbnail
          event.channel.send_embed do |embed|
            embed.title = "Download link"
            embed.colour = 0x5a60e8
            embed.url = url
            embed.description = "#{title}"
            embed.timestamp = Time.now.utc
            embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{thumbnail}")
          end
        else
          event.respond('Not an instagram url')
        end
      end
    end
  end
end