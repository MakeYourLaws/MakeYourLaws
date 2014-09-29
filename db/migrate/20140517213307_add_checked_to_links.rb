class AddCheckedToLinks < ActiveRecord::Migration
  def change
    add_column :links, :checked, :boolean, default: false, null: false
  end
end
