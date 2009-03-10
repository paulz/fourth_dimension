require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::ZeroDimensionalSpace do
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

  it "should not create a figure with a size other than 0" do
    lambda do
      @singularity.cube(1)
    end.should raise_error(::RuntimeError, "Point can only be size zero")

    lambda do
      @singularity.triangle(5)
    end.should raise_error(::RuntimeError, "Point can only be size zero")
  end

  share_examples_for "a point" do
    it "should be zero in any measurement" do
      @figure.should be_a(Geometry::Point)
      @figure.side.should == 0
      @figure.volume.should == 0
      @figure.vertices.should == 1
    end
  end


  context "#cube" do
    before :all do
      @figure = @singularity.cube(0)
    end
    it_should_behave_like "a point"
  end

  context "#triangle" do
    before :all do
      @figure = @singularity.triangle(0)
    end

    it_should_behave_like "a point"

    it "hight should be zero" do
      @singularity.triangle(0).hight.should == 0
    end
  end
end