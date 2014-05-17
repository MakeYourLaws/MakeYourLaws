class Search < ActiveRecord::Base
  has_many :search_results
  # FIXME: should have_many polymorphic
  has_many :results, through: :search_results, source_type: 'Tweet', source: :result
  has_many :links, -> { uniq }, through: :results

  # TODO: use real status machine
  scope :created, -> {where(status: 'created')}
  scope :processing, -> {where(status: 'processing')}
  scope :not_processing, -> {where.not(status: 'processing')}
  scope :done, -> {where(status: 'done')}
  scope :pending, -> { not_processing.where(["status = 'created' OR updated_at + INTERVAL update_frequency SECOND < ?", Time.now])}
end
