class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.jsonb :profile, default: {}
      t.timestamps
    end
  end
end
