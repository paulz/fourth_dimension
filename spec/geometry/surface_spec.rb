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
    SQRT_3 = Math.sqrt(3.0)
    SQRT_3_DIV_2 = Math.sqrt(3.0) / 2

    before :all do
      @triangle = @surface.triangle(1)
    end

    it "should be have triangle of side 1" do
      @triangle.side.should == 1
      @triangle.area.should < 1
      @triangle.vertices.should == 3
      @triangle.volume.should == 0.4330127018922193
    end

    context "#height" do
      it "should be less then a side" do
        @triangle.height.should > 0
        @triangle.height.should < @triangle.side
      end

      it "should form in a right-angled triangle with half a side and a side as hypotenuse" do
        Math.hypot(@triangle.height, @triangle.side/2).should be_very_close(@triangle.side)
      end

      it "should be sqrt(3)/2=%1.2f/2=%1.2f" % [SQRT_3, SQRT_3_DIV_2] do
        @triangle.height_in_two_dimensions.should == @triangle.height
        @triangle.height.should be_very_close(SQRT_3_DIV_2)
      end

    end

    describe "#calc_high" do
      it "should approximate value of height with 3 digits, but not equal" do
        @triangle.calc_height(1000).should == 0.866
        0.866.should_not == @triangle.height
      end

      (2..6).each do |precision|
        it "should approximate with #{precision} digits precision" do
          @triangle.calc_height(10**precision).should be_close(@triangle.height, 1.0/(10**precision))
        end
      end

      it "should produce different values depending on precision" do
        @triangle.calc_height(100).should_not == @triangle.calc_height(100000)
      end

      it "should raise an exception when unable to approximate" do
        lambda do
          Math.stub!(:hypot).and_return(1000)
          @triangle.calc_height(100)
        end.should raise_error(RuntimeError, "Unable to calculate height with precision 100, side=1.0")
      end
    end

    it "#analize_height" do
      @triangle.analize_height.should == @triangle.height
      @triangle.over_analize_height.should == @triangle.height
    end

    describe "#area" do
      it "should be height by half a side" do
        @triangle.area.should == @triangle.height * @triangle.side / 2
      end

      it "should be sqrt(3)/4 by side square" do
        @triangle.area.should == SQRT_3 / 4 * @triangle.side ** 2
      end

      it "should have area four times large then one of a half a side" do
        @triangle.area.should == 4 * @surface.triangle(0.5).area
      end
    end
  end
end