require_relative '../lib/hangman'

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
			expect(hangman.word).to eq('p__p')
		end

		it 'should accept any case char' do
			expect(hangman.word).to eq('p__p')
		end

	end

	context 'upcase guesses' do
		
		before do
			hangman.make_guess('P')
		end

		it 'should return downcase' do
			expect(hangman.word).to eq('p__p')
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

		it "should say the player lose" do
			expect(hangman.game_state).to eq('Lost')
			expect(hangman.game_over).to eq(true)
		end

	end

	context 'when a player guesses "plop"' do

		before do
			hangman.make_guess('p')
			hangman.make_guess('l')
			hangman.make_guess('o')
			hangman.make_guess('p')
		end

		it 'should return 10 lives' do
			expect(hangman.lives).to eq(10)
		end

		it 'should show whole word' do
			expect(hangman.word).to eq('plop')
		end

		it 'should say the player has won' do
			expect(hangman.game_state).to eq('Won')
			expect(hangman.game_over).to eq(true)
		end


	end

end
