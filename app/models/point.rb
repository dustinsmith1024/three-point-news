class Point < ActiveRecord::Base
  belongs_to :post
  attr_accessible :content, :link, :published, :post, :image_url
end
