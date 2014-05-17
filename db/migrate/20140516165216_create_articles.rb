class CreateArticles < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name, index: true
      t.boolean :major, index: true
      t.boolean :print, default: false
      t.references :link
    end

    create_table :journalists do |t|
      t.string :name, index: true
      t.boolean :lawyer
      t.references :link
      t.text :notes
    end

    create_table :phones do |t|
      t.string :phone_number, index: true
      t.boolean :fax, default: false
      t.boolean :sms, default: false
      t.boolean :smart, default: false # e.g. do we have an auth app on it
    end

    create_table :phone_usages do |t|
      t.references :emailer, polymorphic: true, index: true
      t.string :usage # work, cell, home, etc
      t.datetime :confirmed

      t.timestamps
    end

    create_table :emails do |t|
      t.string :email, index: true
      t.boolean :google # google account? e.g. for hangouts / gdoc / etc
    end

    create_table :email_usages do |t|
      t.references :emailer, polymorphic: true, index: true
      t.string :usage
      t.datetime :confirmed

      t.timestamps
    end

    create_table :articles do |t|
      t.references :link, index: true # can be null if not publicly available
      t.references :duplicate_of, default: nil # if it's just a repost of another article
      t.references :journalist, index: true
      t.references :publication, index: true
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
    end
  end
end
