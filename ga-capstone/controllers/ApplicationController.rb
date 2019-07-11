class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# enable :sessions

	use Rack::Session::Cookie,  :key => 'rack.session',
	                            :path => '/',
	                            :secret => "as;dlfkja;sdlfkja;sldkfja;lskdjfa;lsdkjf"

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'guitars'
	)

	views_path = File.expand_path('../../views', __FILE__)
	set :views, views_path
	set :public_dir, File.expand_path('../../public', __FILE__)

	use Rack::MethodOverride
	set :method_override, true


	get '/' do
		redirect '/'
		# erb :home
	end

	get '/test' do
		test_text = "Guitarmy is live!"
		binding.pry
		"Pry finished. #{test_text}"
	end

	get '/404' do
		erb :error_404
	end 

	get '*' do
		halt 404
		erb :error_404
	end
end