class AddUserRefToPosts < ActiveRecord::Migration[5.2]
  def change
    # 募集者と投稿を紐付ける外部参照
    add_reference :posts, :recruiter, foreign_key: { to_table: :users }
  end
end
