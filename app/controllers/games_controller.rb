require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @random_letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(url).read
    english = JSON.parse(dictionary)
    english = english["found"]
    # Is the word and English word (API)
    # Is that word included in random letters
    # Are they both true
    # raise
    @split_word = @word.upcase.split("")
    correct = (@split_word - @random_letters.split()).empty?

    if english == true && correct == true
      @score = "Congratulations! #{@word} is a valid English word!"
    elsif english == true && correct == false
      @score = "Sorry but #{@word} can't be built out of #{@random_letters}"
    elsif english == false && correct == true
      @score = "Sorry but #{@word} doesn't seem to be a valid English word"
    else
      @score = "Sorry but that's wrong"
    end
  end
end
