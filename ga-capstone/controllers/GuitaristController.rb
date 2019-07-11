class GuitaristController < ApplicationController
	# before do 
	# puts "filter is running"
	# if !session[:logged_in]
	# 	session[:message] = {
	# 		success: false,
	# 		status: "bad",
	# 		message: "You must be logged in to do that."
	# 	}
	# 	redirect '/users/login'
	# end

	#Index Guitarists
	get '/' do
		user = User.find_by({ :username => session[:username] })
		@guitarists = user.guitarists

		erb :guitarist_index
	end

	#New Guitarists
	get '/new' do 
		@bands = Band.all
		@guitars = Guitar.all
		erb :guitarist_new
	end

	#Create Guitarists
	post '/new' do
		new_guitarist = Guitarist.new
		new_guitarist.guitarist_url = params[:guitarist_url]
		new_guitarist.name = params[:name]




		logged_in_user = User.find_by({:username => session[:username]})
		new_guitarist.user_id = logged_in_user.id

		# band id
		# new_guitarist.band_id = logged_in_user.id
		# guitar_ids= guitar_ids 
		# new_guitarist.guitar_id = logged_in_user.id

		new_guitarist.save

		# session[:message] = {
		# 	success: true,
		# 	status: "good",
		# 	message: "#{guitarist_name} has been added."
		# }
		redirect '/guitarists'
	end

	#Show Guitarists
	get '/guitarists' do
		erb :guitarist_index
	end

	#Edit Guitarists
	get '/:id/edit' do
		@guitarist = Guitarist.find params[:id]
		@band = Band.all
		# get all guitars (later: mayer limit to the ones added by logged in user), 
		# so you can make checkboxes on guitarist edit
		@guitar = Guitar.all
		erb :guitarist_edit
	end

	#Update Guitarists
	put '/:id' do
		guitarist_update = Guitarist.find params[:id]
		guitarist_update.guitarist_url = params[:guitarist_url]
		guitarist_update.name = params[:name]
		guitarist_update.save
		
		# GET GUITAR IDS FROM TEMPLATE, 
		# FOR EACH GUITAR ID:
			# CREATE ENTRY IN THRU TABLE WITH THIS GUIITARIST ID AND THAT GUITAR ID



		session[:message] = {
			success: true,
			status: "good",
			message: "Updated guitarist info."
		}
		redirect '/guitarists'
	end

	#Destroy Guitarists
	delete '/:id' do
		guitarist = Guitarist.find params[:id]
		guitarist.destroy

		session[:message] = {
			success: true, 
			status: "good",
			message: "Guitarist deleted."
		}
		redirect '/guitarists'
	end
end










