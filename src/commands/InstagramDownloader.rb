require_relative '../utils/Parser'

module FibyBot
  module Commands
    class InstagramDownloader extend Discordrb::Commands::CommandContainer
      command :igd do |event|
        message = event.content.split('igd ')[1]
        if message.match(/(?:(https|http):\/\/)?(?:w{3}\.)?(instagram.com\/)(p|reel*\/)(.*)/
          event.message.delete
          title, desc, stats, video, image =  Parser::MetaTagsParser.parse(message)

          url = video.nil? ? image : video
          event.channel.send_embed do |embed|
            embed.title = "Download Link"
            embed.colour = 0x5a60e8
            embed.url = url
            embed.description = title
            if !desc.nil? && !stats.nil?
              embed.add_field(name: "Description", value: desc)
              embed.add_field(name: "Stats", value: stats)
            end
          end
        else
          event.respond('Not an instagram post/reel')
        end
      end
    end
  end
end