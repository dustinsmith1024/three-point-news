class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.boolean :published
      t.string :image_url
      t.integer :team_id

      t.timestamps
    end
    add_index :posts, :team_id
  end
end
