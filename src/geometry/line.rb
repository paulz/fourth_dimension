module Geometry
  class Line < Space
    def initialize
      super 1
    end

    def segment side
      Figure.new side, self
    end

    def cube side
      segment side
    end
  end

end