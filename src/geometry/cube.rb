require File.dirname(__FILE__)+ "/figure.rb"

module Geometry
  class Cube < Figure
    def volume
      case space.dimentions
      when 0, 1:
        super
      else
        from_previous_dimention.volume * side
      end
    end

    def vertices
      case space.dimentions
      when 0, 1
        super
      else
        2 * from_previous_dimention.vertices
      end
    end
  end

  class Square < Cube
    def initialize side, space
      raise "Square can only be created on a surface" if space.dimentions != 2
      super side, space
    end

    alias_method :area, :volume

    def from_previous_dimention_class side
      space.previous.cube side
    end
  end
end