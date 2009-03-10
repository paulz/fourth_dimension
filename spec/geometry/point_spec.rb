require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::ZeroDimensionalSpace do
  context "zero dimensional space is a point" do
    before(:all) do
      @singularity = Geometry::ZeroDimensionalSpace.new
    end

    it "should be valid as a string" do
      @singularity.to_s.should == "Space of 0 dimensions"
    end

    it "should have depth of 0" do
      @singularity.dimensions.should == 0
    end

    it "should have point with zero side" do
      @singularity.point.side.should == 0
      @singularity.point.volume.should == 0
    end

    it "should not a figure with a size other than 0" do
      lambda do
        @singularity.cube(1)
      end.should raise_error(::RuntimeError, "Point can only be size zero")

      lambda do
        @singularity.triangle(5)
      end.should raise_error(::RuntimeError, "Point can only be size zero")
    end

    context "#cube" do
      it "side and volume should be zero" do
        @singularity.cube(0).should be_a(Geometry::Point)
        @singularity.cube(0).volume.should == 0
        @singularity.cube(0).vertices.should == 1
      end
    end

    context "#triangle" do
      it "side and volume should be zero" do
        @singularity.triangle(0).should be_a(Geometry::Point)
        @singularity.triangle(0).side.should == 0
        @singularity.triangle(0).hight.should == 0
        @singularity.triangle(0).volume.should == 0
        @singularity.triangle(0).vertices.should == 1
      end
    end
  end
end