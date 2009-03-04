module Geometry

  class Figure
    attr_reader :side
    attr_reader :space

    def initialize side, space
      @side = side + 0.0
      @space = space
    end

    def vertices
      return 1 + space.dimentions
    end

    def volume
      side
    end

    protected

    def from_previous_dimention with_side = side
      if with_side == side
        @previous ||  @previous = from_previous_dimention_class(with_side)
      else
        from_previous_dimention_class(with_side)
      end
    end

    def from_previous_dimention_class side
      self.class.new side, space.previous
    end

  end
end