require "google/cloud/translate/v2"
require "pry"

ENV["TRANSLATE_PROJECT"]     = "tokyo-dynamo-348700"
ENV["TRANSLATE_CREDENTIALS"] = "slownik.json"

client = Google::Cloud::Translate::V2.new
translation = client.translate "kot", to: "en", from: "pl"
binding.pry




