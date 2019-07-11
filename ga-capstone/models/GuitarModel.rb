class Guitar < ActiveRecord::Base
	belongs_to :user # irrelevant to main relations, just to track who added
	
	# --- many to many: use thru table to connect to guitarists
	has_many :guitarists, :through => :instrument_choices
	# -- add other side of one to many (HAS MANY) with choices
	has_many :instrument_choices
end