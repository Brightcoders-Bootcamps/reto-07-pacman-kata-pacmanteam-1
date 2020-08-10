# frozen_string_literal: true

require_relative 'pacman.rb'
require_relative 'ghost.rb'
require_relative 'direction.rb'
require 'matrix'
require 'pry'

# Board class
class Board
  attr_reader :dimension, :board, :row, :column

  def initialize(dimension)
    @dimension = dimension
    @row = nil
    @column = nil
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
      loop_validations(pacman)
      break if pacman.dead?
    end

    puts pacman.score
  end

  def loop_validations(pacman)
    set_pacman_coordinates(pacman)
    direction = Direction.new(pacman.direction, @row, @column, dimension).calculate
    pacman = pacman_update_direction(pacman)
    board_element = board[@row, @column] 
    pacman_steps_validations(board_element, pacman)
  end

  def pacman_update_direction(pacman)
    direction = Direction.new(pacman.direction, @row, @column, dimension).calculate
    pacman.update_direction(direction)
    pacman
  end

  def pacman_steps_validations(board_element, pacman)
    return pacman.kill_him if board_element.class == Ghost
    validate_not_walls(board_element, pacman)
    validate_points(board_element, pacman)
    validate_walls(board_element, pacman)
  end

  def validate_not_walls(board_element, pacman)
    return if board_element == "|"

    reset_space
    set_pacman(pacman)
  end

  def validate_walls(board_element, pacman)
    return if board_element != "|"
    
    direction = next_direction(pacman.direction)
    pacman.update_direction(direction)
  end

  def validate_points(board_element, pacman)
    pacman.walk if board_element == 'o'
  end

  def set_pacman_coordinates(pacman)
    @row = pacman.watch_coordinate(pacman)[pacman.direction][:row]
    @column = pacman.watch_coordinate(pacman)[pacman.direction][:column]
  end

  def next_direction(actual_direction)
    index = board_directions.find_index(actual_direction) + 1
    index = 0 if index > board_directions.size
    board_directions[index]
  end

  def board_directions
    ["up", "left", "down", "rigth"]
  end

  def reset_space
    board[@row, @column] = ''
  end

  def set_pacman(pacman)
    board[@row, @column] = pacman
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
