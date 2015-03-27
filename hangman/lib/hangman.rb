class Hangman

	def initialize(hidden_word)
		@hidden_word = hidden_word
		@guesses = []
	end

	def make_guess(guess)
		@guesses << guess.downcase
	end

	def lives
		@guesses.reduce(10) do |lives,guess|
			unless @hidden_word.include?(guess)
				lives -= 1
			end
			lives
		end
	end

	def word
		@hidden_word.each_char.map do |char|
			@guesses.include?(char) ? char : '_'
		end.join
	end

	def game_state
		if game_over && !lives.zero? 
			"Won"
		elsif game_over && lives.zero?
			"Lost"
		end
	end

	def game_over
		lives.zero? || !word.include?('_')
	end

end
