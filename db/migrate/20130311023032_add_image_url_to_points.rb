class AddImageUrlToPoints < ActiveRecord::Migration
  def change
    add_column :points, :image_url, :string
  end
end
