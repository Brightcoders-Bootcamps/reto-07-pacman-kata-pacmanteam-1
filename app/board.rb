# frozen_string_literal: true

require_relative 'pacman.rb'
require_relative 'ghost.rb'
require 'matrix'
require 'Pry'

# Board class
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
      board_element = board[pacman.watch_coordinate[pacman.direction][:row], pacman.watch_coordinate[pacman.direction][:column]] 
      pacman_steps_validations(board_element, pacman)
      break if pacman.dead?
    end
  end

  def pacman_steps_validations(board_element, pacman)
    if board_element.class == Ghost
      pacman.dead = true
    elsif board_element == 'o'
      pacman.update_score
      board[pacman.coordinate_row, pacman.coordinate_column] = ''
      board[pacman.watch_coordinate[pacman.direction][:row], pacman.watch_coordinate[pacman.direction][:column]] = pacman
      case pacman.direction do
      when "up"
        pacman.coordinate_row = pacman.coordinate_row - 1
      when "left"
        pacman.coordinate_column + 1
      when "down"
        pacman.coordinate_row + 1
      when "right"
        pacman.coordinate_column -1
      end
    elsif "|"
      index = board_directions.find_index(pacman.direction) + 1
      index = 0 if index > board_directions.size
      new_direction = board_directions[index]
      pacman.direction = new_direction
    else
      board[pacman.coordinate_row, pacman.coordinate_column] = ''
      board[pacman.watch_coordinate[pacman.direction][:row], pacman.watch_coordinate[pacman.direction][:column]] = pacman
    end
  end

  def board_directions
    ["up", "left", "down", "rigth"]
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