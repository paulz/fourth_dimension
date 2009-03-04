module Geometry
  class Surface < Space
    def initialize
      super 2
    end

    def square side
      Square.new side, self
    end
  end
end