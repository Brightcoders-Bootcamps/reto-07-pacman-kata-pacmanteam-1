#require 'gosu'
require_relative 'pacman.rb'
require_relative 'ghost.rb'
require 'matrix'
require 'Pry'
class Board
  def initialize(board)
   @board = board
  end

  def build
    game_values_array = [Ghost.new, "o", "|", "-", "o"]
    Matrix.build(10) { game_values_array.sample }
  end
end

a = Board.new(10)
puts a.build
