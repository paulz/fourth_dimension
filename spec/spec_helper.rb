require "spec"
require File.dirname(__FILE__)+ '/../src/geometry/space.rb'

module Spec
  module Matchers
    def be_very_close(expected, very_small_delta = ::Float::EPSILON)
      be_close(expected, very_small_delta)
    end
  end
end
