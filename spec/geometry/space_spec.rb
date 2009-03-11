require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::ThreeDimensionalSpace do
  before :all do
    @space = Geometry::ThreeDimensionalSpace.new
  end

  it "depth should be 3" do
    @space.dimensions.should == 3
    @space.to_s.should == "Space of 3 dimensions"
  end

  context "3D figures" do
    it "#cube" do
      @space.cube(1).side.should == 1
      @space.cube(1).volume.should == 1
      @space.cube(2).volume.should == 8
      @space.cube(17).volume.should == 17 ** 3

      @space.cube(1).vertices.should == 8
    end

    describe "#tetrahedron" do
      before :all do
        @tetrahedron = @space.tetrahedron(1)
        @tetrahedron.side.should == 1
      end

      it "should have 4 vertices" do
        @tetrahedron.vertices.should == 4
      end

      describe "#volume" do
        it "should be 2**3=8 times smaller when side is 2 times smaller" do
          @space.tetrahedron(2).volume.should == 8 * @tetrahedron.volume
        end

        it "should be sqrt(2)/12 by side cube, that is %1.2f/12=%1.2f" % [Math.sqrt(2.0), Math.sqrt(2.0)/12] do
          @tetrahedron.volume.should be_very_close(Math.sqrt(2.0) * @tetrahedron.side ** 3 / 12)
          @tetrahedron.volume.should be_very_close(0.117851130197758)
        end

        it "should approximate volume by slices" do
          @space.tetrahedron(2).calc_volume(100).should == 8 * @space.tetrahedron(1).calc_volume(100)

          @tetrahedron.calc_volume(10000).should be_close(@tetrahedron.volume, 0.0001)
        end
      end

      context "#height" do
        it "should have a known height of sqrt(2/3)=sqrt(2)/sqrt(3)=%1.2f/%1.2f=%1.2f" % [Math.sqrt(2.0), Math.sqrt(3.0), Math.sqrt(2.0/3)] do
          @tetrahedron.height.should be_close(Math.sqrt(2.0/3), 0.001)
        end

        [0, 1, 2, 50].each do |size|
          it "should be equal to side %2.2f by square root of 2/3 = %1.2f" % [size, size * Math.sqrt(2.0/3)] do
            @space.tetrahedron(5).height.should be_very_close(5 * Math.sqrt(2.0/3))

            tetrahedron = @space.tetrahedron(size)
            tetrahedron.height.should be_close(size * Math.sqrt(2.0/3), ::Float::EPSILON * (1 + size))
          end
        end

        it "should form a right triangular with previous height and a third of it" do
          surface = @space.previous
          previous_height = surface.triangle(1).height
          @tetrahedron.height.should < previous_height
          Math.hypot(@tetrahedron.height, previous_height/3).should be_very_close(previous_height)
        end
      end
    end
  end
end