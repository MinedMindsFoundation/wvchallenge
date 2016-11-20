require 'minitest/autorun'
require_relative 'hangman.rb'

class TestHangman < Minitest::Test
	def test_word_stored_in_memory
		game = Game.new("hello")
		assert_equal("hello", game.word)
	end

	def test_hello_has_5_characters
		game = Game.new("hello")
		assert_equal(5, game.get_length)
	end

	def test_hello_gives_5_initial_blanks
		game = Game.new("hello")
		assert_equal(["_", "_", "_", "_", "_"], game.get_initial_blanks)
	end

	def test_returns_true_for_e_in_hello
		game = Game.new("hello")
		assert_equal(true, game.correct_guess?("e"))
	end

	def test_returns_true_for_a_in_hello
		game = Game.new("hello")
		assert_equal(false, game.correct_guess?("a"))
	end

	def test_game_starts_with_0_incorrect_guesses
		game = Game.new("hello")
		assert_equal(0,game.incorrect_guesses)
	end

	def test_progress_at_start_is_all_blanks
		game = Game.new("hello")
		assert_equal(["_", "_", "_", "_", "_"], game.progress)
	end

	def test_update_progress_with_guess
		game = Game.new("hello")
		game.update_progress("l")
		assert_equal(["_", "_", "l", "l", "_"], game.progress)
	end

	def test_update_incorrect_guesses
		game = Game.new("hello")
		game.update_incorrect_guesses
		assert_equal(1, game.incorrect_guesses)
	end

	def test_no_letters_guessed_at_start
		game = Game.new("hello")
		assert_equal([], game.letters_guessed)
	end

	def test_update_letters_guessed
		game = Game.new("hello")
		game.update_letters_guessed('a')
		assert_equal(['a'], game.letters_guessed)
	end

	def test_make_guess_with_valid_letter
		game = Game.new("hello")
		game.make_guess('h')
		assert_equal(['h'], game.letters_guessed)
		assert_equal(["h","_", "_", "_", "_"], game.progress)
		assert_equal(0,game.incorrect_guesses)
	end

	def test_make_incorrect_guess
		game = Game.new("hello")
		game.make_guess('j')
		assert_equal(['j'],game.letters_guessed)
		assert_equal(["_","_", "_", "_", "_"],game.progress)
		assert_equal(1,game.incorrect_guesses)
	end

	def test_game_won_when_blanks_filled
		game = Game.new("hello")
		game.progress = ["h", "e", "l", "l", "o"]
		assert_equal(true, game.won?)
	end

	def test_game_lost_with_10_incorrect_guesses
		game = Game.new("hello")
		game.incorrect_guesses = 10
		assert_equal(true, game.lost?)
	end
end

