ActiveAdmin.register Project do
  permit_params :name, :content, :short_content, :image, :purpose, :category_id

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :image, as: :file
      f.input :purpose
      f.input :category
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
    table_for project.contributions do

    end
  end
end
