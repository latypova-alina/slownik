require "interactor"
require_relative "giphy"
require_relative "translate"
require_relative "unite"
require_relative "word_forms/word_forms"

class WordDescription
  include Interactor::Organizer

  organize WordForms::WordForms, Translate, Giphy, Unite
end
