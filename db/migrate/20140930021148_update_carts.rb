class UpdateCarts < ActiveRecord::Migration
  def change
    change_table :carts do |t|
      t.remove_index :user_id

      t.rename :user_id, :owner_id
      t.string :owner_type, default: 'User' # polymorphic - User or Profile
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
      t.index [:owner_type, :owner_id, :name]
      t.index :state
    end

    # A cart item is either a recipient or a proxy bundle (i.e. another cart).
    # Carts are the notional bundling and weighting of recipients. They are
    # instantiated through a transaction, which de-normalizes them into an
    # actual set of specific payments.

    # There are two special cases:
    # 1. Donations to MYL.
    #  These are automatically added and can be changed, but raise warning if low,
    #   and are ignored/reset from proxies.
    # 2. Mandatory payments to MYL for processing costs.
    #  These are not cart items, but rather transactional items. The amount is taken
    #   off the top, based on cost to process payment, cost to disburse, etc.
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
      t.remove :proportion
      t.integer :weight, defaut: 1, null: false

      t.integer :lock_version
      t.timestamps

      t.index [:cart_id, :item_type, :item_id], unique: true
      t.index [:item_type, :item_id]
    end
  end
end
