class Team < ActiveRecord::Base
  has_many :posts
  attr_accessible :league, :name, :image_url
end
