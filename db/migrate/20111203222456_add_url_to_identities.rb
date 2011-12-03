class AddUrlToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :url, :string # canonical URL for this identity's external profile
  end
end
