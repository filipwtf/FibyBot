require 'nokogiri'
require 'rest-client'

module Parser

  def self.get_html(url)
    html = RestClient::Request.execute(:method => :get, :url => url).body
    parsed_page = Nokogiri::HTML.parse(html)
  end

  def self.get_og_tags(page)
    og_tags = {}
    page.xpath('//meta').map { |node|
      if node.values[0].match?(/(og:)(\w*)/)
        og_tags[node.values[0]] = node.values[1]
      end
    }.compact

    return og_tags
  end
  
  class MetaTagsParser
    def self.parse(url)
      page = Parser.get_html(url)
      
      og_tags = Parser.get_og_tags(page)
      
      if og_tags.has_key?('og:description')
        if !og_tags.has_key?('og:video')
          stats, desc = og_tags['og:description'].split(' - ')
        else
          stats = "Video dimension: " +  og_tags["og:video:width"] + 'x' + og_tags["og:video:height"]
          desc = og_tags['og:description']
        end 
      end
  
      return og_tags['og:url'], desc, stats, og_tags['og:video'], og_tags['og:image']
    end
  end
  
  class ProfileParser
    def self.parse(url)
      page = Parser.get_html(url)
      og_tags = Parser.get_og_tags(page)
      stats = og_tags['og:description'].split(' - ')[0]
      name = og_tags['og:title'].split(' • ')[0]
      return name, stats, og_tags['og:image']
    end
  end
end