require File.dirname(__FILE__)+ "/figure.rb"

module Geometry
  class Cube < Figure
    def volume
      case space.dimensions
      when 0, 1:
        super
      else
        from_previous_dimension.volume * side
      end
    end

    def vertices
      case space.dimensions
      when 0, 1
        super
      else
        2 * from_previous_dimension.vertices
      end
    end

    def self.previous_class
      Cube
    end
    
  end

end