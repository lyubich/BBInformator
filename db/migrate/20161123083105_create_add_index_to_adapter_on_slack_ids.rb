class CreateAddIndexToAdapterOnSlackIds < ActiveRecord::Migration[5.0]
  def change
    add_index :adapters, "(data->'slack_id')", using: :gin, name: 'index_adapter_on_data_slack_id'
  end
end
