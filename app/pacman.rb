class Pacman
  attr_accessor :coordinate_row, :coordinate_column, :dead
  
  def initialize
    @coordinate_row = nil
    @coordinate_column = nil
    @dead = false
  end
  
  def dead?
    dead
  end

  def walk
  end

  def eat
  end
  
end

