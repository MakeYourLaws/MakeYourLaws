class FecAos < ActiveRecord::Base
  # rails g migration fec_aos name:string saos_id:string description:string

  has_many :fec_ao_docs
end