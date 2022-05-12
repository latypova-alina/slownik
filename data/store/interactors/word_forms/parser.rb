require_relative "../../lib/response_getter"
require "active_support/core_ext/module"
require "nokogiri"
require "open-uri"
require_relative "constants.rb"

module WordForms
  class Parser
    include Interactor
    include ResponseGetter
    include WordForms::Constants

    delegate :word_forms_array, :is_verb, :word_forms, to: :context

    def call
      context.word_forms = {}
      is_verb ? parse_as_verb : parse_as_noun
    end

    private

    def parse_as_verb(i = 0, pronoun = "", time = "")
      word_forms_array.each do |word_form|
        if PRONOUNS.include?(word_form)
          pronoun = word_form
          time = TIMES[i]
          context.word_forms[pronoun] ||= {}
          context.word_forms[pronoun][time] ||= []
          if !context.word_forms[pronoun][time].empty?
            i+=1
            time = TIMES[i]
            context.word_forms[pronoun][time] ||= []
          end
        else
          context.word_forms[pronoun][time] << word_form
        end
      end
    end

    def parse_as_noun(przypadek = "")
      word_forms_array.each do |word_form|
        if PRZYPADKI.include?(word_form)
          przypadek = word_form
          context.word_forms[przypadek] ||= ""
        else
          context.word_forms[przypadek] = normalize(word_form)
        end
      end
    end

    def normalize(word)
      no_spaces_word = URI.encode(word).gsub("%C2%A0", "")
      URI.decode(no_spaces_word)
    end
  end
end
