require "httparty"
require "pry"
require "nokogiri"
require "open-uri"
require "facets/string/squish"


class Sort
  URL = "http://aztekium.pl"
  WORD_TYPES = ["odmiana", "przypadki"]
  PRONOUNS = ["Ja", "Ty", "On/Ona/Ono", "My", "Wy", "Oni/One"]
  PRZYPADKI = ["Mianownik", "Dopełniacz", "Celownik", "Biernik", "Narzędnik", "Miejscownik", "Wołacz"]
  TIMES = ["Czas przeszły", "Czas teraźniejszy", "Czas przyszły"]
  TAG = "b"

  def initialize(word)
    get_response(word)
    @sorted_words = {}
  end

  def sort
    verb? ? sort_as_verb : sort_as_noun
    @sorted_words
  end

  private

  def get_response(word)
    WORD_TYPES.each do |type|
      @response = Nokogiri::HTML(open("#{URL}/#{type}/#{URI.encode(word)}"))

      break if verb?
    end
  end

  def verb?
    @_verb ||= PRONOUNS.all? { |pronoun| text_array.include?(pronoun) }
  end

  def text_array
    @response.css(TAG).map{ |n| n.children.text }
  end

  def sort_as_verb(i = 0, pronoun = "", time = "")
    text_array.each do |word_form|
      if PRONOUNS.include?(word_form)
        pronoun = word_form
        time = TIMES[i]
        @sorted_words[pronoun] ||= {}
        @sorted_words[pronoun][time] ||= []
        if !@sorted_words[pronoun][time].empty?
          i+=1
          time = TIMES[i]
          @sorted_words[pronoun][time] ||= []
        end
      else
        @sorted_words[pronoun][time] << word_form
      end
    end
  end

  def normalize(word)
    word.encode("ASCII", "UTF-8", undef: :replace, replace: " ").strip
  end

  def sort_as_noun(przypadek = "")
    text_array.each do |word_form|
      if PRZYPADKI.include?(word_form)
        przypadek = word_form
        @sorted_words[przypadek] ||= ""
      else
        @sorted_words[przypadek] = normalize(word_form)
      end
    end
  end
end
