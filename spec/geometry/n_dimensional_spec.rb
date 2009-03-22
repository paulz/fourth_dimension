require File.dirname(__FILE__)+ '/../spec_helper.rb'


(2..15).each do |n|

  describe Geometry::Space.new(n) do
    before :all do
      @space = Geometry::Space.new(n)
    end

    describe "#dimentions" do
      it "should be #{n}" do
        @space.dimensions.should == n
      end
    end

    share_examples_for "similar #{n} dimensional figures" do
      it "volume should be proportional to it's side in power of #{n}" do
        (@figure1.volume / @figure2.volume).should be_very_close( (@figure1.side / @figure2.side) ** n)
      end

      it "volume to side in power #{n} should be same" do
        (@figure1.volume / @figure1.side ** n).should be_very_close((@figure2.volume / @figure2.side ** n))
      end

      it "should have same number of vertices" do
        @figure1.vertices.should == @figure2.vertices
      end
    end

    describe "#cube" do
      describe "#vertices" do
        it "should be 2^n=2^#{n}=#{2**n}, independent of size a side" do
          @space.cube(1).vertices.should == 2**n
        end
      end

      describe "#volume" do
        before :all do
          @figure1 = @space.cube(3)
          @figure2 = @space.cube(7)
        end

        it_should_behave_like "similar #{n} dimensional figures"
      end
    end

    describe "#simplex" do
      before :all do
        @figure1 = @space.simplex(3)
        @figure2 = @space.simplex(7)
      end

      describe "#vertices" do
        it "should be #{n + 1}" do
          @space.simplex(5).vertices.should == n + 1
        end
      end

      describe "#hight" do
        it "should be smaller then a side" do
          @space.simplex(17).height.should < @space.simplex(17).side
        end

        it "should be proportional to the side" do
          (@figure1.height/@figure2.height).should be_very_close(@figure1.side/@figure2.side)
        end

        it "should be proportional to a triangle height from previous dimention" do
          (@space.simplex(5).height / @space.previous.simplex(5).height).should be_very_close(@space.previous_height_ratio)
        end
      end

      describe "#volume" do
        it_should_behave_like "similar #{n} dimensional figures"
      end
    end
  end
end