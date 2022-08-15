require 'nokogiri'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ('A'..'Z').to_a
    @letters = @alphabet.sample(10)
  end

  def score
    @submitted_word = params[:word].chars
    @letters_array = params[:word_value].chars
    counter = 0
    @submitted_word.each do |letter|
      if @letters_array.include?(letter.capitalize)
        counter += 1
        # @letters_array[index] = "."
      end
    end

    if @submitted_word.length == counter
      # API CALL
      url = "https://wagon-dictionary.herokuapp.com/#{@submitted_word.join}"
      html_file = URI.open(url).read
      html = JSON.parse(html_file)
      @found = html["found"]
    end
  end

end
