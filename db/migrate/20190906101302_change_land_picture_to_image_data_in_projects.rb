class ChangeLandPictureToImageDataInProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :thumb_picture, :image_data
  end
end
