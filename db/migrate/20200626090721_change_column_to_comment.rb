class ChangeColumnToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :content, :string, limit: 255, default: '', null: false
  end
end
