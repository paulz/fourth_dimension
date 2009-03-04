module Geometry

  class Square < Cube
    def initialize side, space
      raise "Square can only be created on a surface" if space.dimensions != 2
      super side, space
    end

    alias_method :area, :volume

    def from_previous_dimension_class side
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
#    alias_method :square, :volume
  end

  class Figure
    def area
      raise RuntimeError, "area is defined only for 2 dimensional spaces, got #{space.dimensions}" if space.dimensions != 2
      volume
    end
  end
end