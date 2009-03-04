module Geometry

  class Square < Cube
    def initialize side, space
      raise "Square can only be created on a surface" if space.dimentions != 2
      super side, space
    end

    alias_method :area, :volume

    def from_previous_dimention_class side
      space.previous.cube side
    end
  end
  
  class Surface < Space
    def initialize
      super 2
    end

    def square side
      Square.new side, self
    end
    alias_method :square, :volume
  end

  class Figure
    def area
      raise RuntimeError, "area is defined only for 2 dimentional spaces, got #{space.dimentions}" if space.dimentions != 2
      volume
    end
  end
end