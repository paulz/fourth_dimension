module Geometry

  class Tetrahedron < Triangle
    def initialize side, space = ThreeDimensionalSpace.new
      super
      raise RuntimeError, "Tertrahedron only exists in 3 dimensional space" if space.dimensions != 3
    end
  end

  class ThreeDimensionalSpace < Space
    def initialize
      super 3
    end

    def tetrahedron side
      Tetrahedron.new side, self
    end

    alias_method :triangle, :tetrahedron
  end
end