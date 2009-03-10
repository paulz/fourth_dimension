module Geometry
  class Segment < Figure
    def initialize side, space
      raise "Segment can only be created on a line" if space.dimensions != 1
      super side, space
    end

    alias_method :length, :volume
  end

  class Line < Space
    def initialize
      super 1
    end

    def segment side
      Segment.new side, self
    end

    def cube side
      segment side
    end
  end
end