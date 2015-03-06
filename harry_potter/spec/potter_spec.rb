RSpec.describe "A purchase of Harry Potter Books" do
  context "Basket" do
    it "contains 1 unique book" do
      let(:books)  { ["book1"] }
      let(:basket) { Basket.new(books) }

      expect(basket.total).to eq(8)
    end
  end
end
