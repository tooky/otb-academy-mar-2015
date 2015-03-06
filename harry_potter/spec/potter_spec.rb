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
      # [2,2,2,2,2] = 5 * 8 =
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
      # [1,4] = 2 * 8 = 16 * 0.95 = 15.2
      expect(basket.total).to eq(45.2)
    end

  end
end
