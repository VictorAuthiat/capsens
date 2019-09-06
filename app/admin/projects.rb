ActiveAdmin.register Project do
  permit_params :name, :content, :short_content, :thumb_picture, :land_picture, :purpose, :category_id

  index do
    id_column
    column :name
    column :content
    column :short_content
    column :thumb_picture
    column :land_picture
    column :purpose
    column :created_at

    actions
  end

  filter :name
  filter :created_at
  filter :short_content
  filter :created_at
  filter :purpose

  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :created_at
        row :short_content
        row :created_at
        row :purpose
      end
    end
  end
end
