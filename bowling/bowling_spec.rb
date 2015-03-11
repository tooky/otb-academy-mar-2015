class Game
  def score(line)
    line.reduce(0) { |s,v| s + v }
  end
end

RSpec.describe "A game of bowling" do

  let(:game) { Game.new }

  it "worst... game.. evar" do
    line = Array.new(20, 0)

    expect( game.score(line) ).to eq(0)
  end

  it "all singles" do
    line = Array.new(20, 1)

    expect( game.score(line) ).to eq(20)
  end

  it "all spares" do
    line = Array.new(21, 5)

    expect( game.score(line) ).to eq(150)
  end

  it "all strikes" do
    line = Array.new(12, 10)

    expect( game.score(line) ).to eq(300)
  end
end
