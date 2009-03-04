require File.dirname(__FILE__)+ "/space.rb"

module Geometry
  class ZeroDimensionalPoint < Space
    def initialize
      super 0
    end

    def cube side
      raise RuntimeError, "no side with length more then 0 possible in 0 dimensions" if side != 0
      super
    end

    def triangle side
      raise RuntimeError, "no side with length more then 0 possible in 0 dimensions" if side != 0
      super
    end
  end
end