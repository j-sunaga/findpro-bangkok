class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false, default: '',limit: 50
    add_column :users, :profile_image, :text
    add_column :users, :content, :text
    add_column :users, :applicant_or_recruiter, :integer, null: false, default: 0,limit: 1
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
