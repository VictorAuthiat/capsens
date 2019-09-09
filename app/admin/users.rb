ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :password, :password_confirmation

  member_action :impersonate do
    sign_in(:user, resource)
    redirect_to after_sign_in_path_for(resource)
  end
  action_item :impersonate, only: :show do
    link_to('Se connecter', impersonate_admin_user_path(resource), target: '_blank')
  end
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :updated_at
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :created_at
  filter :last_sign_in_at
  filter :sign_in_count

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
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
        row :first_name
        row :last_name
        row :created_at
        row :updated_at
        row :sign_in_count
        row :last_sign_in_at
        row :last_sign_in_ip
      end
    end
  end
end
