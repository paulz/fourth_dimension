module Geometry
  class Triangle < Figure
    def hight
      hight_from_simple_formula
    end

    def hight_in_two_dimensions
      side * Math.sqrt(3)/2
    end

    def calc_hight precision = 10000
      inc = side / (precision + 0.0)
      previous_hight = from_previous_dimension.hight
      precision.downto(1) do |percent|
        sample = inc * percent
        if Math.hypot(sample, previous_hight/space.dimensions) < previous_hight
          return sample
        end
      end
      raise RuntimeError, "Unable to calculate hight with precision #{precision}, side=#{side}"
    end

    def analize_hight
      Math.sqrt( side ** 2 - (side/space.dimensions) ** 2 )
    end

    def over_analize_hight
      case space.dimensions
      when 0, 1:
        volume
      else
        previous = from_previous_dimension.over_analize_hight
        Math.sqrt( previous ** 2 - (previous/space.dimensions) ** 2 )
      end
    end

    def calc_volume precision = 10000
      case space.dimensions
      when 0, 1:
        0
      else
        previous_volume = 0
        precision.downto(0) do |portion|
          previous_volume += from_previous_dimension(side * portion/precision).volume
        end
        previous_volume * hight / precision
      end
    end

    def calc_simplex_formula
      n = space.dimensions
      side ** n * Math.sqrt(n + 1) / Math.sqrt(2 ** n) / factorial(n)
    end

    def hight_from_simple_formula
      n = space.dimensions
      n == 0 ? 0 : side * Math.sqrt((n + 1.0) / 2 / n )
    end

    def volume
      case space.dimensions
      when 0, 1:
        super
      else
        from_previous_dimension.volume * hight / space.dimensions
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

end