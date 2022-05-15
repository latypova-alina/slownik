require_relative "../../lib/response_getter"
require "active_support/core_ext/module"
require "nokogiri"
require "open-uri"
require_relative "constants.rb"

module WordForms
  class Info
    include Interactor
    include ResponseGetter
    include WordForms::Constants

    delegate :word, :is_verb, :word_forms_array, to: :context

    def call
      get_response do
        WORD_TYPES.each do |type|
          @response = Nokogiri::HTML(open("#{URL}/#{type}/#{URI.encode(word)}"))

          break if verb?
        end
      end
    end

    private

    def verb?
      context.is_verb = PRONOUNS.all? { |pronoun| word_forms_array.include?(pronoun) }
    end


    def word_forms_array
      return [] unless @response

      context.word_forms_array = @response.css(TAG).map{ |n| n.children.text }
    end
  end
end
