class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :datetime
    add_column :users, :nationality, :string
    add_column :users, :country_of_residence, :string
    add_column :users, :mango_pay_id, :string
    add_column :users, :wallet_id, :string
  end
end
