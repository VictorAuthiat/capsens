ActiveAdmin.register Category do
  permit_params :name
  actions :all, except: :show

  index do
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name
  filter :created_at
end
