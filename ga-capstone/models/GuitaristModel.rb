class Guitarist < ActiveRecord::Base
	belongs_to :user # not using this relation, just to know who added guitarist
	belongs_to :band # one to many



	has_many :guitars, through: :instrument_choices # update this to use through table
end