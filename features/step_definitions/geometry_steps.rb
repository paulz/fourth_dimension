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

Then /^height forms a right triangle: (.+) \+ (.+) == (.+)$/ do |height_square, half_side_square, side_square|
  height_square.to_f.should be_very_close(@triangle.height**2, Float::EPSILON * 4)
  half_side_square.to_f.should be_very_close((@triangle.side/2)**2)
  side_square.to_f.should be_very_close(@triangle.side**2)
  (height_square.to_f + half_side_square.to_f).should be_very_close(side_square.to_f)
end
