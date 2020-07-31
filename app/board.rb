# frozen_string_literal: true

require_relative 'pacman.rb'
require_relative 'ghost.rb'
require 'matrix'
require 'Pry'

# board class
class Board
  attr_reader :dimension, :board
  def initialize(dimension)
    @dimension = dimension
  end

  def build
    game_values_array = [Ghost.new, 'o', '|', '-', 'o']
    @board = Matrix.build(dimension) { game_values_array.sample }
  end

  def center_pacman(pacman)
    coordinate = (dimension / 2)
    board[coordinate, coordinate] = pacman
    pacman.coordinate_row = coordinate
    pacman.coordinate_column = coordinate
  end

  def board_iteration(pacman)
    loop do
      board_element = board[pacman.coordinate_row, pacman.coordinate_column - 1]
    
      break if pacman.dead?
    end
  end

  def print_board
    print board
  end
end

board = Board.new(10)
pacman = Pacman.new
board.build
board.center_pacman(pacman)
board.print_board