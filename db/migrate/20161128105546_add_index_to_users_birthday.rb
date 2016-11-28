class AddIndexToUsersBirthday < ActiveRecord::Migration[5.0]
  def change
    add_index :users, "(profile->'birthday')", using: :gin, name: 'index_user_on_profile_birthday'
  end
end
