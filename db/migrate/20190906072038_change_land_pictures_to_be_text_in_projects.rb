class ChangeLandPicturesToBeTextInProjects < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :land_picture, :text
  end
end
