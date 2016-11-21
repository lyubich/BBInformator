class CreateAdapters < ActiveRecord::Migration[5.0]
  def change
    create_table :adapters do |t|
      t.string :type
      t.integer :user_id
      t.jsonb :data, default: {}
      t.timestamps
    end
  end
end
