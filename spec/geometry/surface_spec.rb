require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Surface do

  before :all do
    @surface = Geometry::Surface.new
  end

  it "should be depth of 2" do
    @surface.dimentions.should == 2
    @surface.to_s.should == "Space of 2 dimentions"
  end

  context "flat figures" do
    before :all do
      @square = @surface.square(1)
      @twice_smaller_square = @surface.square(0.5)
    end

    it "should be have square of side 1" do
      @square.side.should == 1
      @square.area.should == 1
      @square.vertices.should == 4
    end

    it "half a side square should have four" do
      @twice_smaller_square.area.should == @square.area / 4
      @twice_smaller_square.vertices.should == 4
    end

    it "should not define square other than surface" do
      lambda do
        @one_dimention.square(1)
      end.should raise_error(NoMethodError)

      lambda do
        Geometry::Square.new 1, Geometry::Space.new(1)
      end.should raise_error(RuntimeError, "Square can only be created on a surface")
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

          @triangle.hight_in_two_dimentions.should == @triangle.hight
          @triangle.hight.should be_close(0.8660254037844385, ::Float::EPSILON)
        end

        it "should form in a right-angled triangle with half a side and a side as hypotenuse" do
          Math.hypot(@triangle.hight, @triangle.side/2).should be_close(@triangle.side, ::Float::EPSILON)
        end

      end

      it "#calc_high" do
        @triangle.calc_hight(1000).should be_close(@triangle.hight, 0.001)
        @triangle.calc_hight(10000).should be_close(@triangle.hight, 0.0001)
        @triangle.calc_hight(100000).should be_close(@triangle.hight, 0.00001)

        @triangle.calc_hight(100).should_not == @triangle.calc_hight(100000)
      end

      it "#analize_hight" do
        @triangle.analize_hight.should == @triangle.hight
        @triangle.over_analize_hight.should == @triangle.hight
      end

      it "should have area of hight by half a side" do
        @triangle.area.should == @triangle.hight * @triangle.side / 2
      end

      it "should have area four times large then one of a half a side" do
        @triangle.area.should == 4 * @surface.triangle(0.5).area
      end
    end
  end

end