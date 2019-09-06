class RemoveThumbFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :thumb_data
  end
end
