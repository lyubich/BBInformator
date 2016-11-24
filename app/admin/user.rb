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
      f.input :profile, as: :text
    end
    f.actions
  end
end