require_relative "set_up.rb"
require_relative "sort.rb"
require 'aws-sdk-dynamodb'
require 'dotenv/load'
require "google/cloud/translate/v2"
require_relative "translate.rb"
require_relative "giphy.rb"

include Translate

Aws.config[:credentials] = Aws::Credentials.new(
  ENV['AWS_ACCESS_KEY_ID'],
  ENV['AWS_SECRET_ACCESS_KEY']
)

dynamodb = Aws::DynamoDB::Client.new
SetUp.create_table(dynamodb)

TEST_WORDS_FILE = "../resources/cleared_words.txt"

threads = []

start = Time.now
i=0

File.foreach(TEST_WORDS_FILE).each_slice(200) do |slice|
  if i <= 810
    i+=1
    next
  end

  slice.each do |line|
    threads << Thread.new do
      word = line.strip
      sorted_forms = Sort.new(word).sort
      en_word = translate(word)
      dynamodb.put_item({
        table_name: 'Slownik',
        item: {
          "word": word,
          "en": en_word,
          "gifs": Giphy.new(en_word).gifs
        }.merge(sorted_forms)
      })
    end
  end
  threads.each(&:join)
end

dynamodb.count
finish = Time.now

puts finish-start
#162599 - records
#326345 - translate requests
#разница в 163746
