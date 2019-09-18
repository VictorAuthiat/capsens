class AddBankwireToContributions < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :bankwire, :boolean, default: false
  end
end
