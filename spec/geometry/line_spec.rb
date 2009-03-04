require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Line do

  before :all do
    @line = Geometry::Line.new
  end

  it "#dimensions should be 1" do
    @line.dimensions.should == 1
    @line.previous.dimensions.should == 0
    @line.to_s.should == "Space of 1 dimensions"
  end

  share_examples_for "segment of a line" do
    it "should have 2 vertices" do
      @segment.vertices.should == 2
    end
    it "should have a volume equal to a side" do
      @segment.volume.should == @segment.side
    end
  end

  context "all figures are like segments" do

    describe "#cube" do
      before(:all) do
        @segment = @line.cube(5)
      end
      it_should_behave_like "segment of a line"
    end

    describe "#triangle" do
      before(:all) do
        @segment = @line.triangle(7)
      end
      it_should_behave_like "segment of a line"

      it "#hight" do
        @segment.hight.should == @segment.side
      end
    end
  end
end