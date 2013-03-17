class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :content
      t.boolean :published
      t.string :link
      t.references :post

      t.timestamps
    end
    add_index :points, :post_id
  end
end
