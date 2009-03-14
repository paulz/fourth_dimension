require File.dirname(__FILE__)+ '/../spec_helper.rb'
require 'benchmark'
include Benchmark

describe "Calculations should be relatively fast" do

  before(:all) do
    @four_dimensions = Geometry::Space.new(4)
    @pentachoron = @four_dimensions.simplex(10)
  end

  after :each do
    @benchmark.utime.should be_close(0.069, 0.04)
  end

  PERFORMANCE_FACTOR = 1.4

  it "#volume" do
    @benchmark = Benchmark.measure do
      (1..2000 * PERFORMANCE_FACTOR).each do
        @pentachoron.volume
      end
    end
  end

  it "#calc_volume" do
    @benchmark = Benchmark.measure do
      (1..10 * PERFORMANCE_FACTOR).each do
        @pentachoron.calc_volume 100
      end
    end
  end

  it "#calc_simplex_formula" do
    @benchmark = Benchmark.measure do
      (1..4000 * PERFORMANCE_FACTOR).each do
        @pentachoron.calc_simplex_formula
      end
    end
  end

  it "#over_analize_height" do
    @benchmark = Benchmark.measure do
      (1..2000 * PERFORMANCE_FACTOR).each do
        @pentachoron.over_analize_height
      end
    end
  end

  it "#calc_height" do
    @benchmark = Benchmark.measure do
      (1..500 * PERFORMANCE_FACTOR).each do
        @pentachoron.calc_height 1000
      end
    end
  end

  it "#height" do
    @benchmark = Benchmark.measure do
      (1..10000 * PERFORMANCE_FACTOR).each do
        @pentachoron.height
      end
    end
  end

end