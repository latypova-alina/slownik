require "httparty"
require "pry"
require "nokogiri"
require "open-uri"
require_relative "sort.rb"
require "mongo"

client = Mongo::Client.new("mongodb://127.0.0.1:27017/test")
db = client.database
collection = client[:words]

docs = []

binding.pry

start = Time.now

File.foreach("test.txt") do |line|
  word = line.strip
  next if collection.find({"word": word}).any?
  sorted_forms = Sort.new(word).sort
  collection.insert_one({ word: word }.merge(sorted_forms))
end

finish = Time.now

puts finish - start

binding.pry


#collection.delete_many()

