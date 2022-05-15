require "aws-sdk-dynamodb"
require "dotenv/load"

module CreateTable
  class << self
    def create_table(dynamodb)
      dynamodb.create_table({
        table_name: 'Slownik',
        key_schema: [
          {attribute_name: "word", key_type: "HASH"},
        ],
        attribute_definitions: [
          {attribute_name: 'word', attribute_type: 'S'},
        ],
        provisioned_throughput: {
          read_capacity_units: 4,
          write_capacity_units: 15
        }
      })
    rescue Aws::DynamoDB::Errors::ResourceInUseException
      puts "Database exists"
    end
  end
end


