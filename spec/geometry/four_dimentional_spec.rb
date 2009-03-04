require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Space do

  context "four dimensional simplex" do
    before :all do
      @four_dimensions = Geometry::Space.new(4)
      @pentachoron = @four_dimensions.simplex(1)
    end

    it "#volume" do
      @pentachoron.volume.should be_close(0.02329237, 0.00001)
      @pentachoron.vertices.should == 5
      # See formular at http://en.wikipedia.org/wiki/Simplex
      # http://upload.wikimedia.org/math/1/0/4/10457cdca57c10861902004469b9cf02.png
      @pentachoron.volume.should be_close(@pentachoron.calc_simplex_formula, ::Float::EPSILON)
      @four_dimensions.simplex(2).calc_simplex_formula.should == 16 * @pentachoron.calc_simplex_formula
      @four_dimensions.simplex(2).hight_from_simple_formula.should be_close(2 * @pentachoron.hight, 2 * ::Float::EPSILON)

      @pentachoron.calc_volume(1000).should be_close(0.02329237, 0.001)

      @four_dimensions.cube(1).volume.should == 1
      @four_dimensions.cube(2).volume.should == 16 * @four_dimensions.cube(1).volume
      @four_dimensions.simplex(2).volume.should == 16 * @pentachoron.volume
      @four_dimensions.simplex(1).hight_from_simple_formula.should be_close(@four_dimensions.simplex(1).hight, ::Float::EPSILON)
    end

    it "#height" do
      hight = @pentachoron.hight
      hight.should be_close(0.790569415042095,
              0.0000000000000003)

      @pentachoron.calc_hight(10000).should be_close(hight, 0.0001)
    end
  end


end