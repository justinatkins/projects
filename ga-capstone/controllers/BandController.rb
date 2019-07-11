class BandController < ApplicationController
	# before do 
	# 	puts "\nsession in the filter: "
	# 	pp session

	# 	puts "filter is running"
	# 	if !session[:logged_in]

	# 		session[:message] = {
	# 			success: false,
	# 			status: "neutral",
	# 			message: "Sorry, you must be logged in to do that"
	# 		}
	# 		puts "\ni'm about to redirect u\n"
	# 		redirect '/users/login'
	# 	end
	# end

	#Index Bands
	get '/' do
		puts "\n in index, no filter,here's session"
		pp session

		user = User.find_by({ :username => session[:username] })
		@bands = user.bands

		pp @bands
		erb :band_index	
	end

	#New Bands
	get '/new' do
		@guitarists = Guitarist.all
		erb :band_new	
	end

	#Create Bands
	post '/new' do

		new_band = Band.new
		new_band.band_url = params[:band_url]
		new_band.band_name = params[:band_name]

		logged_in_user = User.find_by({:username => session[:username]})
		new_band.user_id = logged_in_user.id


		# new_band.guitarist_id = logged_in_user.id

		new_band.save

		# session[:message] = {
		# 	success: true,
		# 	status: "good",
		# 	message: "#{band_name} has been added."
		# }

		redirect '/bands'
	end

	#Show Bands
	get '/bands' do
		erb :band_index
	end

	#Edit Bands
	get '/:id/edit' do
		@band = Band.find params[:id]
		@guitarist = Guitarist.all
		erb :band_edit
	end

	#Update Bands
	put '/:id' do
		band_update = Band.find params[:id]
		band_update.band_url = params[:band_url]
		band_update.band_name = params[:band_name]
		band_update.save

		session[:message] = {
			success: true,
			status: "good",
			message: "Updated band info."
		}
		redirect '/bands'
	end

	#Destroy Bands
	delete '/:id' do 
		band = Band.find params[:id]
		band.destroy

		session[:message] = {
			success: true,
			status: "good",
			message: "Band deleted."
		}

		redirect '/bands'
	end

end