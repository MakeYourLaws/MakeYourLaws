class UpdateCarts < ActiveRecord::Migration
  def change
    change_table :carts do |t|
      t.remove_index :user_id

      t.rename :user_id, :owner_id
      t.string :owner_type # polymorphic - User or Profile
      t.remove_references :disbursement # (parent) transaction should reference cart, not vice versa
      # t.string :state

      # t.integer :cart_items_count, :default => 0
      t.remove :total_cents # set by user, determines respective amount of items
      t.remove :currency

      t.string :name # for proxies having multiple carts
      # text in markdown
      t.text :reason # for proxy constituents / profile pages / full emails
      t.text :short_reason, limit: 1000 # for summary emails; 1k char ~= 2 paragraphs

      # t.integer :lock_version
      # t.timestamps
      t.index [:owner_id, :owner_type, :name]
      t.index :state
    end

    change_table :cart_items do |t|
      t.remove_index [:cart_id, :committee_id]
      # t.references :cart, :null => false
      t.remove_references :committee

      # TODO: resulting transaction will need an additional legal memo field, eg saying
      #   what committee, race, etc it's for; multicandidate status; ind. exp. vs contrib.; etc.
      #   We're assuming here that that can be always deduced from who pays whom when.

      t.references :item, polymorphic: true, null: false
        # either a Cart (proxy bundle) or LegalIdentity

      # text in markdown
      t.text :reason # for proxy constituents / profile pages
      t.string :short_reason, limit: 140 # for summary emails; 140 characters max
      t.text :message # to be sent to the recipient

      t.remove :amount_cents
      # t.float :proportion # 0..1, proportion of cart total to be spent on this item

      t.index [:cart_id, :item_type, :item_id], unique: true
      t.index [:item_type, :item_id]
    end
  end
end
