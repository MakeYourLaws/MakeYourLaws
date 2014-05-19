class Article < ActiveRecord::Base
  belongs_to :link
  belongs_to :duplicate_of, class_name: 'Article'
  belongs_to :journalist
  belongs_to :publication
  belongs_to :image_link, class_name: 'Link'

end
