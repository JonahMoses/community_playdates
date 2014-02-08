class AddLargeAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :large_avatar, :string
  end
end
