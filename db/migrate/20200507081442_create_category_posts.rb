class CreateCategoryPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :category_posts do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
    add_index :category_posts, [:post_id, :category_id], unique: true
  end
end
