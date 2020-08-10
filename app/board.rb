# frozen_string_literal: true

require_relative 'pacman.rb'
require_relative 'ghost.rb'
require_relative 'direction.rb'
require_relative 'board_validations.rb'
require 'matrix'
require 'pry'

# Board class
class Board
  attr_reader :dimension

  def initialize(dimension)
    @dimension = dimension
  end

  def build
    game_values_array = ['o', Ghost.new, 'o', '|', 'o', 'o']
    @board = Matrix.build(dimension) { game_values_array.sample }
  end

  def center_pacman(pacman)
    coordinate = (dimension / 2)
    board[coordinate, coordinate] = pacman
    pacman.update_coordinate_row(coordinate)
    pacman.update_coordinate_column(coordinate)
  end
  
  def board_iteration(pacman)
    loop do
      validations = BoardValidations.new(@board, pacman)
      validations.run
      pacman = validations.pacman
      board = validations.board
      break if pacman.dead?
    end
  end

  def print_board
    board.each_slice(board.column_size) {|row| p row}
  end
end

board = Board.new(6)
pacman = Pacman.new
board.build
board.center_pacman(pacman)
board.board_iteration(pacman)
board.print_board
