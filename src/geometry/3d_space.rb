module Geometry
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