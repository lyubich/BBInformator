class CreateChangeNameOfColumnInAdapters < ActiveRecord::Migration[5.0]
  def change
    rename_column :adapters, :type, :adapter_type
  end
end
