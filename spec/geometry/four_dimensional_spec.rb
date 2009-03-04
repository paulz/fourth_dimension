require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Space do

  context "four dimensional simplex" do
    before :all do
      @four_dimensions = Geometry::Space.new(4)
      @pentachoron = @four_dimensions.simplex(1)
    end

    context "#simplex" do
      it "#vertices" do
        @pentachoron.vertices.should == 5
      end

      it "#volume" do
        @four_dimensions.simplex(2).volume.should == 16 * @pentachoron.volume

        @pentachoron.volume.should be_close(0.0232923747656228, ::Float::EPSILON)
      end

      it "#calc_simplex_formula" do
        # See formular at http://en.wikipedia.org/wiki/Simplex
        # http://upload.wikimedia.org/math/1/0/4/10457cdca57c10861902004469b9cf02.png
        @pentachoron.calc_simplex_formula.should be_close(@pentachoron.volume, ::Float::EPSILON)
      end

      it "#calc_volume" do
        @pentachoron.calc_volume(1000).should be_close(@pentachoron.volume, 0.001)
      end

      it "#height" do
        hight = @pentachoron.hight
        hight.should be_close(0.790569415042095, ::Float::EPSILON)
        @pentachoron.calc_hight(10000).should be_close(hight, 0.0001)
      end

      it "#hight_from_simple_formula" do
        @pentachoron.hight_from_simple_formula.should be_close(@pentachoron.hight, ::Float::EPSILON)
        @four_dimensions.simplex(2).hight_from_simple_formula.should be_close(2 * @pentachoron.hight, 2 * ::Float::EPSILON)
      end
    end

    context "#cube" do
      it "#vertices" do
        @four_dimensions.cube(7).vertices.should == 16
      end

      it "#volume" do
        @four_dimensions.cube(1).volume.should == 1
        @four_dimensions.cube(10).volume.should == 16 * @four_dimensions.cube(5).volume
      end
    end
  end


end