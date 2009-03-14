Given /^(.*) dimentional space$/ do |dimentions|
  @space = Geometry::Space.new(dimentions.to_i)
end

When /^triangle with side (.+)$/ do |side|
  @triangle = @space.triangle(side.to_f)
end

Then /^it's (.+) should be (.+)$/ do |method, expected|
  @triangle.send(method).should be_very_close(expected.to_f)
end

Then /^it's (.+) should eq sqrt\((.+)\)\/(.+)$/ do |method, square, divider|
  expected = Math.sqrt(square.to_f)/divider.to_f
  @triangle.send(method).should be_very_close(expected)
end

Then /^it's (.+) should eq sqrt\((.+)\)$/ do |method, square|
  expected = Math.sqrt(square.to_f)
  @triangle.send(method).should be_very_close(expected)
end
