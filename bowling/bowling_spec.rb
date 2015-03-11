class Game

  def score(line)
    @frame = 0
    @index = 0
    @line = line
    score = 0

    while @frame < 10
      if spare?
        score += 10 + spare_bonus
        @index += 2
      elsif strike?
        score += 10 + strike_bonus
        @index += 1
      else # a normal frame
        score += normal_frame_score
        @index += 2
      end
      @frame += 1
    end
    return score
  end

  def spare?
    @line[@index] + @line[@index + 1] == 10
  end

  def strike?
    @line[@index] == 10
  end

  def spare_bonus
    @line[@index + 2]
  end

  def strike_bonus
    @line[@index + 1] + @line[@index + 2]
  end

  def normal_frame_score
    @line[@index] + @line[@index + 1]
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

  it "normal game" do
    line = [1,2,5,5,7,0,10,4,3,6,2,3,7,2,1,4,1,8,0]

    expect( game.score(line) ).to eq(87)
  end

  it "steves suggested game" do
    line = [2,4,5,3,1,6,8,2,0,2,6,4,10,7,3,0,10,6,4,7]

    expect( game.score(line) ).to eq(116)
  end
end
