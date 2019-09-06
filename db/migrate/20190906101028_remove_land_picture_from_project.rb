class RemoveLandPictureFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :land_picture
  end
end
