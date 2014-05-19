class Phone < ActiveRecord::Base
  has_many :phone_usages
  has_many :phoners, :through => :phone_usages

  before_save :normalize

  def normalize
    self.phone_number = Phoner::Phone.parse(:phone_number).format(:default_with_extension)
  end

  # :default, :default_with_extension, :europe, :us
  def phone_for format
    Phoner::Phone.parse(self.phone_number).format(format)
  end
end