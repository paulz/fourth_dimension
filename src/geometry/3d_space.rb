module Geometry

  class Tetrahedron < Triangle
    def initialize side, space = ThreeDimentionalSpace.new
      super
      raise RuntimeError, "Tertrahedron only exists in 3 dimentional space" if space.dimentions != 3
    end

    def from_previous_dimention_class side
      space.previous.triangle side
    end
  end

  class ThreeDimentionalSpace < Space
    def initialize
      super 3
    end

    def tetrahedron side
      Tetrahedron.new side, self
    end

    alias_method :triangle, :tetrahedron
  end
end