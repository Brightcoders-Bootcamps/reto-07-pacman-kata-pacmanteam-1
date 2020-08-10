# frozen_string_literal: true

# class BoardValidations
class BoardValidations
  attr_reader :board, :pacman, :board_element

  def initialize(board, pacman)
    @board = board
    @pacman = pacman
  end

  def run
    set_board_element
    update_new_pacman_direction
    board_element_validation
  end

  def row
    pacman.watch_coordinate[pacman.direction][:row]
  end

  def column
    pacman.watch_coordinate[pacman.direction][:column]
  end

  def set_board_element
    @board_element = board[row, column] 
  end

  def update_new_pacman_direction
    dimension = board.column_size
    validated_direction = Direction.new(pacman.direction, row, column, dimension).calculate
    pacman.update_direction(validated_direction)
  end

  def board_element_validation
    return pacman.kill_him if board_element.class == Ghost

    validate_points
    validate_walls
    validate_empty_spaces
  end

  def validate_points
    if board_element == 'o'
      pacman.walk
      board[pacman.coordinate_row, pacman.coordinate_column] = ""
    end
  end

  def validate_walls
    return if board_element != "|"
    
    new_direction = next_direction(pacman.direction)
    pacman.update_direction(new_direction)
  end

  def validate_empty_spaces
    board[row, column] = pacman if board_element == ""
  end

  def next_direction(actual_direction)
    index = board_directions.find_index(actual_direction) + 1
    index = 0 if index > board_directions.size
    board_directions[index]
  end

  def board_directions
    ["up", "left", "down", "rigth"]
  end
end