require "interactor"
require "./lib/store_words/interactors/giphy"
require "./lib/store_words/interactors/translate"
require "./lib/store_words/interactors/unite"
require "./lib/store_words/interactors/word_forms/word_forms"

class WordDescription
  include Interactor::Organizer

  organize WordForms::WordForms, Translate, Giphy, Unite
end
