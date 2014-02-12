class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email

      t.timestamps
      t.index :email, :unqiue => true
    end
  end
end
