class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :topic
      t.text :content
      t.boolean :inline_images

      t.timestamps
    end
    add_index :posts, :topic_id
  end
end
