class AddSessionsTable < ActiveRecord::Migration
  def up
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.integer :lock_version, :default => 0
      
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end

  def down
    drop_table :sessions
  end
end
