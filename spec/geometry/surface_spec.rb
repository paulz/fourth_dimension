require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Surface do

  before :all do
    @surface = Geometry::Surface.new
  end

  it "#dimensions" do
    @surface.dimensions.should == 2
    @surface.to_s.should == "Space of 2 dimensions"
  end

  context "#square" do
    before :all do
      @square = @surface.square(2)
      @twice_smaller_square = @surface.square(1)
    end

    it "area should be square of side" do
      @square.side.should == 2
      @square.area.should == 4
      @square.vertices.should == 4
    end

    it "half a side square should have four times smaller area" do
      @twice_smaller_square.area.should == @square.area / 4
      @twice_smaller_square.vertices.should == 4
    end

    it "should not define square other than surface" do
      lambda do
        Geometry::Square.new 1, Geometry::Space.new(1)
      end.should raise_error(RuntimeError, "Square can only be created on a surface")
    end

  end

  context "#triangle" do
    before :all do
      @triangle = @surface.triangle(1)
    end

    it "should be have triangle of side 1" do
      @triangle.side.should == 1
      @triangle.area.should < 1
      @triangle.vertices.should == 3
    end

    context "#hight" do
      it "should be less then a side" do
        @triangle.hight.should > 0
        @triangle.hight.should < @triangle.side
      end

      it "should form in a right-angled triangle with half a side and a side as hypotenuse" do
        Math.hypot(@triangle.hight, @triangle.side/2).should be_very_close(@triangle.side)
      end

      it "should be sqrt(3)/2=%1.2f/2=%1.2f" % [Math.sqrt(3.0), Math.sqrt(3.0)/2] do
        @triangle.hight_in_two_dimensions.should == @triangle.hight
        @triangle.hight.should be_very_close Math.sqrt(3.0)/2
      end

    end

    describe "#calc_high" do
      it "should approximate value of hight with 3 digits, but not equal" do
        @triangle.calc_hight(1000).should == 0.866
        0.866.should_not == @triangle.hight
      end

      (2..6).each do |precision|
      it "should approximate with #{precision} digits precision" do
        @triangle.calc_hight(10**precision).should be_close(@triangle.hight, 1.0/(10**precision))
      end
      end

      it "should produce different values depending on precision" do
        @triangle.calc_hight(100).should_not == @triangle.calc_hight(100000)
      end

      it "should raise an exception when unable to approximate" do
        lambda do
          Math.stub!(:hypot).and_return(1000)
          @triangle.calc_hight(100)
        end.should raise_error(RuntimeError, "Unable to calculate hight with precision 100, side=1.0")
      end
    end

    it "#analize_hight" do
      @triangle.analize_hight.should == @triangle.hight
      @triangle.over_analize_hight.should == @triangle.hight
    end

    describe "#area" do
      it "should be hight by half a side" do
        @triangle.area.should == @triangle.hight * @triangle.side / 2
      end

      it "should be sqrt(3)/4 by side square" do
        @triangle.area.should == Math.sqrt(3.0) / 4 * @triangle.side ** 2
      end

      it "should have area four times large then one of a half a side" do
        @triangle.area.should == 4 * @surface.triangle(0.5).area
      end
    end
  end
end