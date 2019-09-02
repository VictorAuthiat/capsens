class AddIpToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ip, :string
  end
end
