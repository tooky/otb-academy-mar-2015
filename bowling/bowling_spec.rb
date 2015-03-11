RSpec.describe "A game of bowling" do

  let(:game) { Game.new(line) }

  it "worst... game.. evar" do
    line = Array.new(20, 0)

    expect( game.score ).to eq(0)
  end

end
