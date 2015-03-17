class Basket
  BASE_PRICE = 8

  def initialize(books)
    @books = OptimiseBasket.new(books).basket
  end

  def total
    @books.reduce(0) do |total, set|
      total += (set.size * BASE_PRICE) * discount_value[set.size]
    end
  end
  
  private 

  def discount_value
    { 1 => 1,
      2 => 0.95,
      3 => 0.9,
      4 => 0.8,
      5 => 0.75 }
  end
end

class OptimiseBasket
  attr_reader :basket

  def initialize(basket)
    @basket =  optimise(basket)
  end

  def optimise(basket)
    @optimised = generate_sets(basket)

    while set_should_be_optimised?
      @optimised[get_index(5)].pop
      @optimised[get_index(3)].push(5)      
    end

    return @optimised
  end

  def generate_sets(basket)
    sets = []

    while basket.size > 0
      set = basket.uniq
      sets << set
      set.each { |si| basket.delete_at(basket.index(si)) }
    end

    return sets
  end

  def set_should_be_optimised?
    set_sizes.has_value?(3) && set_sizes.has_value?(5)
  end

  def set_sizes
    @optimised.each.with_index.inject({}) do |hash,(v,i)| 
      hash[i] = v.size
      hash
    end
  end

  def get_index(value)
    set_sizes.rassoc(value).slice(0,1).first
  end

end

RSpec.describe "A purchase of Harry Potter Books" do
  context "Basket" do
    it "contains 1 unique book" do
      books = [1]
      basket =  Basket.new(books)

      #
      # [1] = 1 * 8 = 8
      expect(basket.total).to eq(8)
    end

    it "contains 2 identical books" do
      books = [1,1]
      basket =  Basket.new(books)

      #
      # [1,1] = 2 * 8 = 16
      expect(basket.total).to eq(16)
    end

    it "contains 5 identical books" do
      books = [2,2,2,2,2]
      basket =  Basket.new(books)

      #
      # [2,2,2,2,2] = 5 * 8 = 40
      expect(basket.total).to eq(40)
    end

    it "contains 1 complete set" do
      books = [1,2,3,4,5]
      basket =  Basket.new(books)

      #
      # [1,2,3,4,5] = 5 * 8 = 40 * 0.75 = 30
      expect(basket.total).to eq(30)
    end

    it "contains 2 partial sets" do
      books = [1,2,3,1,2,3]
      basket =  Basket.new(books)

      #
      # [1,2,3] = 3 * 8 = 24 * 0.9 = 21.6
      # [1,2,3] = 3 * 8 = 24 * 0.9 = 21.6
      expect(basket.total).to eq(43.2)
    end

    it "contains 1 full set and 1 partial set" do
      books = [1,2,3,4,5,1,4]
      basket =  Basket.new(books)

      #
      # [1,2,3,4,5] = 5 * 8 = 40 * 0.75 = 30
      # [1,4]       = 2 * 8 = 16 * 0.95 = 15.2
      expect(basket.total).to eq(45.2)
    end

    it "contains set of 3 and 1 single" do
      books = [5,4,3,4]
      basket =  Basket.new(books)

      #
      # [3,4,5] = 3 * 8 = 24 * 0.9 = 21.6
      # [4]     = 1 * 8 = 8 * 1    = 8
      expect(basket.total).to eq(29.6)
    end

    it "3 partial sets and 2 singles" do
      books = [1,1,2,2,3,3,4,5]
      basket =  Basket.new(books)

      #
      # Kata example
      # [1,2,3,4,5] = 5 * 8 = 40 * 0.75 = 30
      # [1,2,3]     = 3 * 8 = 24 * 0.9  = 21.6
      # Wrong
      #
      # 2 x set of 4 is cheaper
      # [1,2,3,4] = 4 * 8 = 32 * 0.8 = 25.6
      # [1,2,3,5] = 4 * 8 = 32 * 0.8 = 25.6
      expect(basket.total).to eq(51.20)
    end

  end
end
