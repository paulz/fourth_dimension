module Geometry
  class Surface < Space
    def initialize
      super 2
    end

    def square side
      Square.new side, self
    end
  end

  class Figure
    def area
      raise RuntimeError, "area is defined only for 2 dimentional spaces, got #{space.dimentions}" if space.dimentions != 2
      volume
    end
  end
end