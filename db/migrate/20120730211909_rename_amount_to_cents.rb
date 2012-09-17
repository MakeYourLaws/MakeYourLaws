class RenameAmountToCents < ActiveRecord::Migration
  def change
    rename_column :paypal_transactions, :amount, :amount_cents
  end
end
