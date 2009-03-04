module Geometry
  class Triangle < Figure
    def hight
      hight_from_simple_formula
    end

    def hight_in_two_dimentions
      side * Math.sqrt(3)/2
    end

    def calc_hight precision = 10000
      inc = side / (precision + 0.0)
      sample = nil
      previous_hight = from_previous_dimention.hight
      precision.downto(0) do |percent|
        sample = inc * percent
        break if (sample ** 2 + (previous_hight/space.dimentions) ** 2 ) < previous_hight ** 2
      end
      sample
    end

    def analize_hight
      Math.sqrt( side ** 2 - (side/space.dimentions) ** 2 )
    end

    def over_analize_hight
      case space.dimentions
      when 0, 1:
        volume
      else
        previous = from_previous_dimention.over_analize_hight
        Math.sqrt( previous ** 2 - (previous/space.dimentions) ** 2 )
      end
    end

    def calc_volume precision = 10000
      case space.dimentions
      when 0, 1:
        0
      else
        previous_volume = 0
        precision.downto(0) do |portion|
          previous_volume += from_previous_dimention(side * portion/precision).volume
        end
        previous_volume * hight / precision
      end
    end

    def calc_simplex_formula
      n = space.dimentions
      side ** n * Math.sqrt(n + 1) / Math.sqrt(2 ** n) / factorial(n)
    end

    def hight_from_simple_formula
      n = space.dimentions
      n > 0 ? side * Math.sqrt((n + 1.0) / 2 / n ) : 0 # to avoid NaN due to division by 0
    end

    def area
      raise "defined Only for 2 dimentions" if space.dimentions != 2
      volume
    end

    def volume
      case space.dimentions
      when 0, 1:
        super
      else
        from_previous_dimention.volume * hight / space.dimentions
      end
    end

    private

    def factorial n
      case n
      when 0
        1
      else
        n * factorial(n-1)
      end
    end

  end

  class Tetrahedron < Triangle
    def initialize side, space
      super
      raise RuntimeError, "Tertrahedron only exists in 3 dimentional space" if space.dimentions != 3
    end

    def from_previous_dimention_class side
      space.previous.triangle side
    end
  end
end