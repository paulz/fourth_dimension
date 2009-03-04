require File.dirname(__FILE__)+ '/../spec_helper.rb'
require 'benchmark'
include Benchmark

describe "Calculations should be relatively fast" do

  before(:all) do
    @four_dimentions = Geometry::Space.new(4)
    @pentachoron = @four_dimentions.simplex(10)
  end

  after :each do
    @benchmark.utime.should be_close(0.069, 0.04)
  end

  it "#volume" do
    @benchmark = Benchmark.measure do
      (1..2000).each do
        @pentachoron.volume
      end
    end
  end

  it "#calc_volume" do
    @benchmark = Benchmark.measure do
      (1..10).each do
        @pentachoron.calc_volume 100
      end
    end
  end

  it "#calc_simplex_formula" do
    @benchmark = Benchmark.measure do
      (1..5000).each do
        @pentachoron.calc_simplex_formula
      end
    end
  end

  it "#over_analize_hight" do
    @benchmark = Benchmark.measure do
      (1..2000).each do
        @pentachoron.over_analize_hight
      end
    end
  end

  it "#calc_hight" do
    @benchmark = Benchmark.measure do
      (1..80).each do
        @pentachoron.calc_hight 1000
      end
    end
  end

  it "#hight" do
    @benchmark = Benchmark.measure do
      (1..10000).each do
        @pentachoron.hight
      end
    end
  end

end