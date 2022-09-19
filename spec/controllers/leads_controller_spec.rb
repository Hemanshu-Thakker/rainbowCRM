RSpec.describe "test" do
    describe "GET index" do
      it "simple response verification" do
        message = "Random message"
        expect(message).to eq('Random message')
      end
    end
  end