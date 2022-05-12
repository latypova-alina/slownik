module SetUp
  def self.create_table(dynamodb)
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
  rescue
    puts "Database exists"
  end
end


