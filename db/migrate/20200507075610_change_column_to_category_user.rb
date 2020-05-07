class ChangeColumnToCategoryUser < ActiveRecord::Migration[5.2]
  def change
    add_index :category_users, [:user_id, :category_id], unique: true
  end
end
