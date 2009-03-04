require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::ZeroDimentionalPoint do
  context "zero dimentional space is a point" do
    before(:all) do
      @singularity = Geometry::ZeroDimentionalPoint.new
    end

    it "should be valid as a string" do
      @singularity.to_s.should == "Space of 0 dimentions"
    end

    it "should have depth of 0" do
      @singularity.dimentions.should == 0
    end

    it "should not a figure with a size other than 0" do
      lambda do
        @singularity.cube(1)
      end.should raise_error(::RuntimeError, "no side with length more then 0 possible in 0 dimentions")

      lambda do
        @singularity.triangle(5)
      end.should raise_error(::RuntimeError, "no side with length more then 0 possible in 0 dimentions")
    end

    context "#cube" do
      it "side and volume should be zero" do
        @singularity.cube(0).side.should == 0
        @singularity.cube(0).volume.should == 0
        @singularity.cube(0).vertices.should == 1
      end
    end

    context "#triangle" do
      it "side and volume should be zero" do
        @singularity.triangle(0).side.should == 0
        @singularity.triangle(0).hight.should == 0
        @singularity.triangle(0).volume.should == 0
        @singularity.triangle(0).vertices.should == 1
        @singularity.triangle(0).calc_volume(1000).should == 0
      end
    end
  end
end