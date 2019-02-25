require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a
    @grid = []
    10.times do
      letter = @letters.sample
      @grid << letter
    end
  end

  def score
    run_game(params[:attempt])
  end

  private

  def grid_check(attempt)
    @grid = params[:grid]
    @grid.chars.all? { |letter| attempt.count(letter) <= @grid.count(letter) }
  end

  def run_game(attempt)
    # TODO: runs the game and return detailed hash of result
    page_string = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    english_word = JSON.parse(page_string)["found"]

    if grid_check(attempt) && english_word == true
      @score = 'You win!'
    else
      @score = 'You lose!'
    end
  end
end
