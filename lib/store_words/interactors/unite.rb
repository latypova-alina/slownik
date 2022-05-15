class Unite
  include Interactor

  delegate :word, :gifs, :en, :word_forms, :result, to: :context

  def call
    context.result = {
      "word": word,
      "en": en,
      "gifs": gifs
    }.merge(word_forms)
  end
end
