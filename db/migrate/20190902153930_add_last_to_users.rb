class AddLastToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last, :datetime
  end
end
