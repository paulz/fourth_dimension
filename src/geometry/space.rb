require File.dirname(__FILE__)+ "/figure.rb"
require File.dirname(__FILE__)+ "/triangle.rb"
require File.dirname(__FILE__)+ "/cube.rb"

module Geometry
  class Space
    attr_reader :dimentions
    attr_reader :previous

    def initialize dimentions
      @dimentions = dimentions
    end

    def previous
      @previous || @previous = dimentions == 0 ? nil : Space.new(dimentions - 1)
    end

    def to_s
      "Space of #{dimentions} dimentions"
    end

    def cube(side)
      Cube.new(side, self)
    end

    def triangle(side)
      Triangle.new(side, self)
    end

    alias_method :simplex, :triangle
  end

  require File.dirname(__FILE__)+ "/point.rb"
  require File.dirname(__FILE__)+ "/line.rb"
  require File.dirname(__FILE__)+ "/surface.rb"
  require File.dirname(__FILE__)+ "/3d_space.rb"
end