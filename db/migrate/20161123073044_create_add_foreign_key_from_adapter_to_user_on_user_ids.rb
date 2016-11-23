class CreateAddForeignKeyFromAdapterToUserOnUserIds < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :adapters, :users, column: :user_id, primary_key: "id"
  end
end
