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

end