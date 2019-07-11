class GuitarController < ApplicationController
# before do 
# 		puts "filter is running"
# 		if !session[:logged_in]

# 			session[:message] = {
# 				success: false,
# 				status: "bad",
# 				message: "Sorry, you must be logged in to do that"
# 			}
# 			redirect '/users/login'
# 	end

	#Index Guitars
	get '/' do
		user = User.find_by({ :username => session[:username] })
		@guitars = user.guitars

		erb :guitar_index	
	end

	#New Guitars
	get '/new' do
		@guitarists = Guitarist.all
		erb :guitar_new	
	end

	#Create Guitars
	post '/new' do

		new_guitar = Guitar.new
		new_guitar.guitar_url = params[:guitar_url]
		new_guitar.year = params[:year]
		new_guitar.make = params[:make]
		new_guitar.model = params[:model]
		new_guitar.finish = params[:finish]


		logged_in_user = User.find_by({:username => session[:username]})
		new_guitar.user_id = logged_in_user.id
		new_guitar.save

		# session[:message] = {
		# 	success: true,
		# 	status: "good",
		# 	message: "#{guitar_name} has been added."
		# }
		redirect '/guitars'
	end

	#Show Guitars
	get '/guitars' do
		erb :guitar_index
	end

	#Edit Guitars
	get '/:id/edit' do
		@guitar = Guitar.find params[:id]
		erb :guitar_edit
	end

	#Update Guitars
	put '/:id' do
		guitar_update = Guitar.find params[:id]
		guitar_update.guitar_url = params[:guitar_url]
		guitar_update.make = params[:make]
		guitar_update.model = params[:model]
		guitar_update.year = params[:year]
		guitar_update.finish = params[:finish]
		guitar_update.save

		session[:message] = {
			success: true,
			status: "good",
			message: "Updated guitar info."
		}
		redirect '/guitars'
	end

	#Destroy Guitars
	delete '/:id' do 
		guitar = Guitar.find params[:id]
		guitar.destroy

		session[:message] = {
			success: true,
			status: "good",
			message: "Guitar deleted."
		}
		redirect '/guitars'
	end
end