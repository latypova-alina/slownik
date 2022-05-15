require "httparty"

class Giphy
  include HTTParty
  base_uri 'api.giphy.com'

  def initialize(word)
    @options = { query: {
      q: word,
      limit: 3,
      rating: 'g',
      api_key: ENV['GIF_API_KEY']
    } }
  end

  def gifs
    retry_counter ||= 0

    response = self.class.get("/v1/gifs/search", @options)

    response["data"].map{ |gif| gif["url"] }
  rescue
    sleep(2)

    if (retry_counter += 1) < 3
      retry
    else
      File.open("errors.txt", "a") do |file|
        file.write("#{@options[:query][:q]} - gifs\n")
      end
    end
  end
end
