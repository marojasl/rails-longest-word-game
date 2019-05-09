require 'time'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @start = Time.new
  end

  def score
    final = Time.new
    time = final - Time.parse(params[:start])
    word = params[:word]
    letters = params[:letters]
    length = word.length
    score = length * 10 - time

    confirmation = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
    if checking_word(word, letters)
      if confirmation["found"] == true
        @result = "Congratulations! #{word.upcase} is a valid English word. Your score is: #{score}"
      else
        @result = "Sorry, but #{word.upcase} does not seem to be a valid English word. Your score is: 0"
      end
    else
        @result = "Sorry, but #{word.upcase} can't be build out of #{letters}. Your score is: 0"
    end
  end

  def checking_word(word, letters)
    word_array = word.upcase.split('')
    letters_array = letters.upcase.split
    word_array.each.all? do |letter|
      letters_array.count(letter.upcase) >= word_array.count(letter.upcase)
    end
    # raise
  end

  def home
  end
end
