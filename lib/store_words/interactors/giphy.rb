require "./lib/response_getter"
require "active_support/core_ext/module"
require "httparty"
require 'dotenv/load'

class Giphy
  include Interactor
  include ResponseGetter
  include HTTParty

  base_uri 'api.giphy.com'

  delegate :word, :gifs, to: :context

  def call
    options = { query: {
      q: word,
      limit: 3,
      rating: 'g',
      api_key: ENV['GIF_API_KEY']
    } }

    context.gifs = get_response do
      response = self.class.get("/v1/gifs/search", options)

      response["data"].map{ |gif| gif["url"] }
    end
  end
end
