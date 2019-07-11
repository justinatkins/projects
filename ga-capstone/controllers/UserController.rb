class UserController < ApplicationController

	#SHOW LOGIN PAGE
	get '/login' do 
		erb :login
	end

	#DO LOGIN PAGE
	post '/login' do

		puts "\n here is session before login"
		pp session

		user = User.find_by username: params[:username]
		pw = params[:password]

		if user && user.authenticate(pw)
			session[:logged_in] = true
			session[:username] = user.username
			session[:message] = {
				success: true,
				status: "good",
				message: "Logged in as ##{user.username}"
			}

			puts "\n here is session after login, we are about to redirect "
			pp session


			redirect '/bands'
		else
			session[:message] = {
				success: false,
				status: "bad",
				message: "Invalid username or password."
			}

			redirect '/users/login'
		end
	end

	#SHOW REGISTER PAGE
	get '/register' do
		erb :register
	end

	#DO REGISTER PAGE
	post '/register' do
		puts "\n here is params in register"
		pp params
		user = User.find_by username: params[:username]
		puts "\n here's the user we found"
		puts user
		if !user
			user = User.new
			user.username = params[:username]
			user.password = params[:password]
			user.save

			session[:logged_in] = true
			session[:username] = user.username
			session[:message] = {
				success: true,
				status: "good",
				message: "Welcome to the site, you are now logged in as #{user.username}"
			}

			redirect '/bands'

		else
			session[:message] = {
				success: false,
				status: "bad",
				message: "Sorry, username #{params[:username]} is already taken. Try a different one."
			}

			redirect '/users/register'
		end
	end

	#LOGOUT
	get '/logout' do
		username = session[:username]
		session.destroy
		session[:message] = {
			success: true,
			status: "neutral",
			message: "User #{username} logged out."
		}

		redirect '/users/login'
	end
end