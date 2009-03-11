require File.dirname(__FILE__)+ '/../spec_helper.rb'
module Geometry

  describe "Cube" do


    before :all do
      @regular_space = Space.new(3)
    end

    it "#new should create Cube with a side in a space" do
      require File.dirname(__FILE__)+ '/../../src/geometry/cube.rb'
      class CubeChild < Cube
        def initialize *args
          super
        end

      end
      @cube_child = CubeChild.new(2, @regular_space)
      @cube = Cube.new(2, @regular_space)
      @cube.side.should == 2
      @cube.space.dimensions.should == 3
      @cube.should be_a(Figure)
      @cube.should be_a(Cube)
    end
  end
end

