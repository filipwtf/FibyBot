require 'nokogiri'
require 'rest-client'

class Parser
  def self.parse(url)
    html = RestClient::Request.execute(:method => :get, :url => url).body

    parsed_page = Nokogiri::HTML.parse(html)
    title = parsed_page.title
    contents = []

    # Tries find the video will be empty if nothing found
    parsed_page.search("meta[property='og:video'], meta[name='content']").map { |n| 
      contents.push(n['content'])
    }

    # Otherwise it will return the image
    parsed_page.search("meta[property='og:image'], meta[name='content']").map { |n| 
      contents.push(n['content'])
    }
    
    return contents[0], contents[1], title
  end
end