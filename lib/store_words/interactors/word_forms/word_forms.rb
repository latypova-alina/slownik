require "interactor"
require_relative "info"
require_relative "parser"

module WordForms
  class WordForms
    include Interactor::Organizer

    organize Info, Parser
  end
end
