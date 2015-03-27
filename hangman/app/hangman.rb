require 'sinatra'
require_relative '../lib/hangman.rb'

enable :sessions

get '/' do
	erb :index
end

post '/' do
	hidden_word = params[:hidden_word]
	session[:hangman] = Hangman.new(hidden_word)
	redirect '/guess'
end

get '/guess' do
	@hangman = session[:hangman]
	if @hangman.game_over
		redirect '/gameover'
	else
		erb :guess
	end
end

post '/guess' do
	hangman = session[:hangman]
	guess = params[:guess]
	hangman.make_guess(guess)
	redirect '/guess'
end

get '/gameover' do
	hangman = session[:hangman]
	session[:hangman] = nil
	"Game over\n You #{hangman.game_state}"
end
