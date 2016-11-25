ActiveAdmin.register User do
  permit_params :profile

  index do
    selectable_column
    id_column
    column :profile
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Profile Details" do
      f.input :profile, as: :text, input_html: { class: 'jsoneditor-target' }
    end
    f.actions
  end
end