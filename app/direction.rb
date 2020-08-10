# class Direction
class Direction
  attr_reader :direction, :row, :column, :dimension

  def initialize(direction, row, column, dimension)
    @direction = direction
    @row = row
    @column = column
    @dimension = dimension
  end

  def calculate
    case direction
    when "up"
      up
    when "left"
      left
    when "rigth"
      rigth
    when "down"
      down
    else
      direction
    end
  end

  def up
    return "left" if row_minor_than_zero && column == (dimension - 1)
    return "rigth" if row_minor_than_zero
    direction
  end

  def left
    return "up" if row == (dimension - 1) && column_minor_than_zero
    return "down" if column_minor_than_zero
    direction
  end

  def rigth
    return "down" if column_greater_that_dimension
    return "up" if row_greater_than_dimension && column_greater_that_dimension
    direction
  end
    
  def down
    return "left" if row_greater_than_dimension
    return "rigth" if row_greater_than_dimension && column == 0
    direction
  end

  def column_greater_that_dimension
    column >= (dimension - 1)
  end

  def row_greater_than_dimension
    row >= (dimension - 1)
  end

  def row_minor_than_zero
    row < 0
  end

  def column_minor_than_zero
    column < 0
  end
end
