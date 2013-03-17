class Post < ActiveRecord::Base
  belongs_to :team
  has_many :points
  attr_accessible :content, :image_url, :published, :team_id # team_id because its not required
end
