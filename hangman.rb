class Game

	attr_accessor :word, :incorrect_guesses, :progress, :letters_guessed

	def initialize(word)
		@word = word
		@incorrect_guesses = 0
		@progress = get_initial_blanks
		@letters_guessed = []
	end

	def get_length
		word.length 
	end

	def get_initial_blanks
		Array.new(get_length, "_")
	end

	def correct_guess?(guess)
		word.include?(guess)
	end

	def update_progress(guess)
		word_array = word.split("")
		word_array.each_with_index do |letter, position|
			if letter == guess
				@progress[position] = letter
			end
		end
	end

	def update_incorrect_guesses
		@incorrect_guesses = @incorrect_guesses + 1
	end

	def update_letters_guessed(guess)
		@letters_guessed << guess
	end

	def make_guess(guess)
		update_letters_guessed(guess)
		if correct_guess?(guess)
			update_progress(guess)
		else
			update_incorrect_guesses
		end
	end

	def won?
		progress.count("_") == 0
	end

	def lost?
		incorrect_guesses == 10
	end

end