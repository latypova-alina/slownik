module Translate
  def translate(word)
    retry_counter ||= 0

    client = Google::Cloud::Translate::V2.new
    translation = client.translate word, to: "en", from: "pl"
    translation.text
  rescue
    sleep(2)

    if (retry_counter += 1) < 3
      retry
    else
      File.open("errors.txt", "a") do |file|
        file.write("#{word} - translate\n")
      end
    end
  end
end
