require "aws-sdk-dynamodb"
require "dotenv/load"

module DynamoDB
  class << self
    def client
      Aws.config[:credentials] = Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )

      Aws::DynamoDB::Client.new
    end
  end
end


