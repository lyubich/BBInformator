ActiveAdmin.register Adapter do
  permit_params :adapter_type, :data

  index do
    selectable_column
    id_column
    column :adapter_type
    column :user_id
    column :data
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Adapter Details" do
      f.input :adapter_type
      f.input :data, as: :text, input_html: { class: 'jsoneditor-target' }
    end
    f.actions
  end
end