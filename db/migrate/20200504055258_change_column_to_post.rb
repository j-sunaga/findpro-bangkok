class ChangeColumnToPost < ActiveRecord::Migration[5.2]
  # 変更後
  def up
    change_column :posts, :title, :string, null: false, default: '',limit: 50
    change_column :posts, :detail, :text, null: true, default: nil
  end

  # 変更前の状態
  def down
    change_column :posts, :title, :string, null: true, default: nil
    change_column :posts, :detail, :text, null: false, default: ''
  end
end
