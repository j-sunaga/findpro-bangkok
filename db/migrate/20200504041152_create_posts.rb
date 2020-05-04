class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :detail
      t.text :post_image
      t.integer :status,default: 0, null: false, limit: 1
      t.datetime :deadline

      t.timestamps
    end
  end
end
