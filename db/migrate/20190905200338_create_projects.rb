class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.text :content
      t.string :short_content
      t.string :land_picture
      t.string :thumb_picture
      t.integer :purpose

      t.timestamps
    end
  end
end
