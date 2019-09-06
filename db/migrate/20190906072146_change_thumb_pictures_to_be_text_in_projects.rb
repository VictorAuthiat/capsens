class ChangeThumbPicturesToBeTextInProjects < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :thumb_picture, :text
  end
end
