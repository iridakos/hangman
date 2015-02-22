class Game
  include ActiveModel::AttributeMethods, ActiveModel::Serializers::JSON

  class GameOverError < StandardError; end

  MAX_FAILED_ATTEMPTS = 5

  attr_accessor :word

  attr_accessor :selected_letters

  def initialize
    @word = 'Hangman'.upcase
    @selected_letters = []
  end

  def attributes
    {'word' => nil,
     'selected_letters' => nil}
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def failed_attempts
    selected_letters.select { |letter|
      !word.include?(letter)
    }.size
  end

  def guessed?
    (word.split('') - selected_letters).empty?
  end

  def finished?
    failed_attempts >= MAX_FAILED_ATTEMPTS || guessed?
  end

  def select!(letter)
    raise GameOverError if finished?
    selected_letters << letter unless selected_letters.include? letter
    word.include? letter
  end
end
