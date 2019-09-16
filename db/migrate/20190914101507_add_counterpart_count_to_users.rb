class AddCounterpartCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :counterparts_counting, :integer, :default => 0
  end
end
