class Band < ActiveRecord::Base
	belongs_to :user # bc user adds band, not part of main relations
	has_many :guitarists # one to many 
end