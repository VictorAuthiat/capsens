ActiveAdmin.register Project do
  permit_params :name, :content, :short_content, :thumb_picture, :land_picture, :purpose, :category_id

  index do
    id_column
    column :name
    # column :content
    # column :short_content
    # column :thumb_picture
    # column :land_picture
    column :purpose
    column :created_at

    actions
  end

  filter :name
  filter :created_at
  filter :purpose

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :short_content
      f.input :thumb_picture, as: :file
      f.input :land_picture, as: :file
      f.input :purpose
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :short_content
        row :thumb_picture
        row :land_pictures
        row :purpose
        row :created_at
      end
    end
  end
end
