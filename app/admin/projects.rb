ActiveAdmin.register Project do
  permit_params :name, :content, :short_content, :image, :purpose, :category_id
  action_item :check_state, only: :show do
    link_to 'check state', url_for(action: :check_state)
  end
  member_action :check_state do
    transaction = ProjectCheck.new.call(project: resource)
    if transaction.success?
    else
      show do
        flash[:error] = transaction.failure[:error]
      end
    end
  end
  index do
    id_column
    column :name
    column :purpose
    column :created_at

    actions
  end

  filter :name
  filter :created_at
  filter :purpose
  filter :aasm_state, as: :select, collection: Project.state

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :image, as: :file
      f.input :purpose
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :short_content
        row :image do |project|
          image_tag project.image[:medium].url
        end
        row :purpose
        row :created_at
      end
    end
  end
end
