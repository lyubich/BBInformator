class CreateAddIndexToAdapterOnSlackNames < ActiveRecord::Migration[5.0]
  def change
    add_index :adapters, "(data->'slack_name')", using: :gin, name: 'index_adapter_on_data_slack_name'
  end
end
