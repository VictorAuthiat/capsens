class AddAmountInCentsToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :amount_in_cents, :integer
  end
end
