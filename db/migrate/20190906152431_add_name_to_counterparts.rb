class AddNameToCounterparts < ActiveRecord::Migration[6.0]
  def change
    add_column :counterparts, :name, :string
  end
end
