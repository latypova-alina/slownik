require_relative "../lib/response_getter"
require "active_support/core_ext/module"

class Translate
  include Interactor
  include ResponseGetter

  delegate :word, :en, to: :context

  def call
    context.en = get_response do
      client = Google::Cloud::Translate::V2.new
      translation = client.translate word, to: "en", from: "pl"
      translation.text
    end
  end
end
