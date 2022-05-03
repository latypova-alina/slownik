require_relative "constants.rb"

module ClearWords
  class << self
    include ClearWords::Constants

    def run
      File.open(CLEARED_WORDS_FILE, "w+") do |file|
        File.foreach(FULL_LIST_WORDS_FILE) do |line|
          next if invalid_ending?(line.strip)

          file.write(line)
        end
      end
    end

    private

    def invalid_ending?(word)
      word.end_with?(*INVALID_ENDINGS)
    end
  end
end
