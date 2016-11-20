require 'sinatra'
require_relative 'hangman.rb'

enable :sessions

get '/' do 
	erb :get_word
end

post '/word' do
	word = params[:chosen_word]
	session[:game] = Game.new(word)
	redirect '/guess'
end

get '/guess' do
	hint = session[:game].progress.join(" ")
	incorrect_guesses = session[:game].incorrect_guesses
	letters_guessed = session[:game].letters_guessed.join(" ")
	images = ["zero.jpg", "one.jpg", "two.jpg", "three.jpg", "four.jpg", "five.jpg", "six.jpg", "seven.jpg", "eight.jpg", "nine.jpg", "ten.jpg"]
	image = "images/" + images[incorrect_guesses]
	erb :get_guess, locals: {hint: hint, incorrect_guesses: incorrect_guesses, image: image, letters_guessed: letters_guessed}
end

post '/guess' do
	guess = params[:guess]
	session[:game].make_guess(guess)
	if session[:game].won?
		result = "You win! :)"
		erb :game_over, locals: {result: result}
	elsif session[:game].lost?
		result = "You lose! :("
		erb :game_over, locals: {result: result}
	else
		redirect '/guess'
	end
end














