class User < ActiveRecord::Base
	has_secure_password
	has_many :bands
	has_many :guitarists
	has_many :guitars
end