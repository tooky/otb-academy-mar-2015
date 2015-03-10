class Hangman

	attr_reader :lives

	def initialize
		@lives = 10
	end

	def word
		'____'
	end

	def make_guess(guess)
		@lives = 9	
	end

end


RSpec.describe 'Hangman' do

	let(:hangman) { Hangman.new }

	context 'when it starts' do

		it 'has correct word state' do
			expect(hangman.word).to eq('____')
		end

		it 'has 10 lives' do
			expect(hangman.lives).to eq(10)
		end

	end

	context "when a player makes a invalid guess" do

		before do
			hangman.make_guess("a")
		end

		it "should decrement the lives" do
			expect(hangman.lives).to eq(9)
		end

		it "should not change word state" do
			expect(hangman.word).to eq('____')
		end

  end

end
