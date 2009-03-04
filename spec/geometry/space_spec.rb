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

    context "#tetrahedron" do
      before :all do
        @tetrahedron = @space.tetrahedron(1)
      end

      it "should have a known volume" do
        @tetrahedron.side.should == 1
        @tetrahedron.vertices.should == 4
        @tetrahedron.volume.should be_close(0.117851130197758, ::Float::EPSILON)
        Geometry::Tetrahedron.new(1).volume.should == @tetrahedron.volume 
        @tetrahedron.volume.should be_close(Math.sqrt(2) * @tetrahedron.side ** 3 / 12, ::Float::EPSILON)

        @space.tetrahedron(2).volume.should == 8 * @tetrahedron.volume
      end

      it "should approximate volume by slices" do
        @space.tetrahedron(2).calc_volume(100).should == 8 * @space.tetrahedron(1).calc_volume(100)

        @tetrahedron.calc_volume(10000).should be_close(@tetrahedron.volume, 0.0001)
      end

      context "#hight" do
        it "should have a known hight of sqrt(2/3)=sqrt(2)/sqrt(3)=%1.2f/%1.2f=%1.2f" % [Math.sqrt(2.0), Math.sqrt(3.0), Math.sqrt(2.0/3)] do
          @tetrahedron.hight.should be_close(Math.sqrt(2.0/3), 0.001)
        end

        [0, 1, 2, 50].each do |size|
          it "should be equal to side %2.2f by square root of 2/3 = %1.2f" % [size, size * Math.sqrt(2.0/3)] do
            @space.tetrahedron(5).hight.should be_close(5 * Math.sqrt(2.0/3), ::Float::EPSILON)

            tetrahedron = @space.tetrahedron(size)
            tetrahedron.hight.should be_close(size * Math.sqrt(2.0/3), ::Float::EPSILON * (1 + size))
          end
        end

        it "should have hight with a triangular to previous hight and a third" do
          surface = @space.previous
          previous_hight = surface.triangle(1).hight
          @tetrahedron.hight.should < previous_hight
          Math.hypot(@tetrahedron.hight, previous_hight/3).should be_close(previous_hight, ::Float::EPSILON) 
        end
      end
    end
  end
end