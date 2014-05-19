class CreateArticles < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name
      t.boolean :major
      t.boolean :print, default: false
      t.references :link

      t.index :link, unique: true
      t.index :name, unique: true # should be given trademark, but might need to be revisited
      t.index :major
      t.index :print
    end

    create_table :journalists do |t|
      t.string :name
      t.boolean :lawyer
      t.references :link
      t.text :notes

      t.index :name # not unique
      t.index :link, unique: true
    end

    create_table :phones do |t|
      t.string :phone_number # should get normalized first
      t.boolean :fax, default: false
      t.boolean :sms, default: false
      t.boolean :smart, default: false # e.g. can we have an auth app on it

      t.index :phone_number, unique: true
    end

    create_table :phone_usages do |t|
      t.references :phoner, polymorphic: true, index: true
      t.references :phone
      t.string :usage # work, cell, home, etc
      t.datetime :confirmed

      t.timestamps

      t.index :phone_id
    end

    create_table :emails do |t|
      t.string :email
      t.boolean :google # google account? e.g. for hangouts / gdoc / etc

      t.index :email, unique: true
    end

    create_table :email_usages do |t|
      t.references :emailer, polymorphic: true, index: true # User or Journalist
      t.references :email
      t.string :usage # personal, work, etc
      t.datetime :confirmed

      t.timestamps

      t.index :email
    end

    create_table :articles do |t|
      t.references :link # can be null if not publicly available
      t.references :duplicate_of, default: nil # if it's just a repost of another article
      t.references :journalist
      t.references :publication
      # TODO: make a proper file column
      t.references :image_link # eg image of a front page print article
      t.date :published
      t.string :title, null: false
      t.string :format, null: false, default: 'text' # text, audio, video
      t.boolean :featured, null: false, default: false # whether it's shown by default ('best of')
      t.boolean :interviewed, null: false, default: false
      t.boolean :unique, null: false, default: false # unique content / unusual POV
      t.boolean :reproduced, null: false, default: false # w/ permission

      t.boolean :reviewed, null: false, default: false
      t.boolean :listed, null: false, default: false # whether it's on our press page

      t.timestamps

      t.index :journalist_id
      t.index :publication_id
      t.index :link, unique: true # can still be null in mysql
      t.index :duplicate_of_id
      t.index :published
      t.index :reviewed
      t.index [:listed, :published]
    end
  end
end
