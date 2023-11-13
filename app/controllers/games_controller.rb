class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @array = []
    10.times do
      @array << ("A".."Z").to_a.sample
    end
  end

  def score
    is_english = longest_word(params[:answer])
    is_using = using_grid?(params[:answer], params[:grid_letters])
    if is_using && is_english
      @text = true
    else
      @text = false
    end
  end

  private

  def longest_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    answer_serialized = URI.open(url).read
    answer = JSON.parse(answer_serialized)
    answer["found"]
  end

  def using_grid?(answer, list_of_letters)
    answer.chars.all? do |letter|
      answer.count(letter) <= list_of_letters.downcase.count(letter)
    end
  end
end
