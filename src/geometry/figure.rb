module Geometry

  class Figure
    attr_reader :side
    attr_reader :space

    def initialize side, space
      @side = side + 0.0
      @space = space
    end

    def vertices
      return 1 + space.dimensions
    end

    def volume
      side
    end

    def approx_volume &block
      if block_given?
        yield
      else
        volume
      end
    end


    protected

    def from_previous_dimension with_side = side
      if with_side == side
        @previous ||  @previous = from_previous_dimension_class(with_side)
      else
        from_previous_dimension_class(with_side)
      end
    end

    def from_previous_dimension_class side
      self.class.previous_class.new side, space.previous
    end

  end
end