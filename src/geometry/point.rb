require File.dirname(__FILE__)+ "/space.rb"

module Geometry
  class Point < Figure
    def initialize side = 0, space = ZeroDimensionalSpace.new
      raise "Point can only be created in zero dimensions" if space.dimensions != 0
      raise "Point can only be size zero" if side != 0
      super side, space
    end

    alias_method :height, :side
  end

  class ZeroDimensionalSpace < Space
    def initialize
      super 0
    end

    def cube side
      point side
    end

    def triangle side
      point side
    end

    def point side = 0
      Point.new side, self
    end

  end
end