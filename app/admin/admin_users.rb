ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      if f.object.new_record?
        f.input :password
      end
    end
    f.actions
  end

  show do
    panel '' do
      attributes_table_for resource do
        row :email
      end
    end
  end
end
