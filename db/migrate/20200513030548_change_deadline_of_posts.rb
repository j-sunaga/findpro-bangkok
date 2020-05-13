class ChangeDeadlineOfPosts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :deadline, :datetime, null: false
  end

  # 変更前の状態
  def down
    change_column :posts, :deadline, :datetime, null: true
  end
end
