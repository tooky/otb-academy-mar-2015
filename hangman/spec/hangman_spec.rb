class Hangman

	attr_reader :lives, :word

	def initialize(hidden_word)
		@lives = 10
		@hidden_word = hidden_word
		@word = '____'
	end

	def make_guess(guess)
		if @hidden_word.include?(guess)
			@word = 'p___'
		else
			@lives -= 1
		end
	end

end


RSpec.describe 'Hangman' do

	let(:hangman) { Hangman.new('plop') }

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

	context 'when a player makes a valid guess' do

		before do
			hangman.make_guess('p')
		end

		it 'should not change the lives' do
			expect(hangman.lives).to eq(10)
		end

		it 'should show the correct guess' do
			expect(hangman.word).to eq('p___')
		end

	end

	context 'when player makes 10 invalid guesses' do
		
		before do 
			("a".."j").each do |guess|
  			hangman.make_guess(guess)
			end
		end

		it "should return 0 lives" do
			expect(hangman.lives).to eq(0)
		end

		it "should not change word state" do
			expect(hangman.word).to eq('____')
		end

	end

end
