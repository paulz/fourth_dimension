require File.dirname(__FILE__)+ "/space.rb"

module Geometry
  class ZeroDimentionalPoint < Space
    def initialize
      super 0
    end

    def cube side
      raise RuntimeError, "no side with length more then 0 possible in 0 dimentions" if side != 0
      super
    end

    def triangle side
      raise RuntimeError, "no side with length more then 0 possible in 0 dimentions" if side != 0
      super
    end
  end
end