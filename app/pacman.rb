# class Pacman
class Pacman
  attr_reader :coordinate_row, :coordinate_column, :dead, :direction
  
  def initialize
    @coordinate_row = nil
    @coordinate_column = nil
    @dead = false
    @score = 0
    @direction = "up"
  end
  
  def dead?
    dead
  end

  def watch_coordinate
    {
      "up" => { row: (@coordinate_row - 1), column: @coordinate_column},
      "rigth" => { row: @coordinate_row, column: (@coordinate_column + 1)},
      "down" => { row: (@coordinate_row + 1), column: @coordinate_column},
      "left" => { row: @coordinate_row, column: (@coordinate_column - 1)}
    }
  end

  def update_coordinates
    direction_coordinate = watch_coordinate[@direction]
    @coordinate_row = direction_coordinate[:row]
    @coordinate_column = direction_coordinate[:column]
  end

  def update_score
    @score = @score + 1
  end

  def score
    @score
  end

  def kill_him
    @dead = true
  end

  def update_coordinate_row(coordinate)
    @coordinate_row =  coordinate
  end

  def update_coordinate_column(coordinate)
    @coordinate_column =  coordinate
  end

  def update_direction(new_direction)
    @direction = new_direction
  end

  def walk
    update_score
    update_coordinates
  end
end