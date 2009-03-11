require "spec"
require File.dirname(__FILE__)+ '/../src/geometry/space.rb'

module Spec
  module Matchers
    def be_very_close(expected, delta = ::Float::EPSILON)
      simple_matcher do |actual, matcher|
        matcher.failure_message = "expected #{expected} +/- (< #{delta}), got #{actual}, expected-actual=#{expected-actual}"
        matcher.description = "be close to #{expected} (within +- #{delta})"
        (actual - expected).abs < delta
      end
    end
  end
end
