class AddThumbImageToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :thumb_data, :text
  end
end
