class Search < ActiveRecord::Base
  has_many :search_results
  # FIXME: should have_many polymorphic
  has_many :results, through: :search_results, source_type: 'Tweet', source: :result

  # TODO: use real status machine
  scope :created, -> {where(status: 'created')}
  scope :processing, -> {where(status: 'processing')}
  scope :not_processing, -> {where.not(status: 'processing')}
  scope :done, -> {where(status: 'done')}
  scope :pending, -> { not_processing.where("updated_at < updated_at + update_frequency")}
end
