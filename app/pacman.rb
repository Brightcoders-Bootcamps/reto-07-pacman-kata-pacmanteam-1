class Pacman
  attr_accessor :coordinate_row, :coordinate_column, :dead, :score, :direction
  
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

  def walk
  end

  def eat
  end

  def watch_coordinate
    {
      "up" => { row: (coordinate_row - 1), column: coordinate_column},
      "rigth" => { row: coordinate_row, column: (coordinate_column + 1)},
      "down" => { row: (coordinate_row + 1), column: coordinate_column},
      "left" => { row: coordinate_row, column: (coordinate_column -1)}
    }
  end

  def update_score
    score = score + 1
  end
end

