class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contribution, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.text :content
      t.string :name

      t.timestamps
    end
  end
end
