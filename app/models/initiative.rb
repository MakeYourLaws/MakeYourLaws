class Initiative < ActiveRecord::Base
  resourcify

  ELECTION_TYPES = %w(Primary General Special)
  INITIATOR_TYPES = %w(Legislature Citizen Commission Automatic)
  INITIATIVE_TYPES = ['Constitutional Amendment', 'Statute', 'Bond', 'Veto', 'Question',
                      'Combined Constitutional Amendment & Statute', 'Affirmation', 'Recall']
  validates :election_type, inclusion: { in: ELECTION_TYPES }, allow_blank: true
  validates :initiator_type, inclusion: { in: INITIATOR_TYPES }, allow_blank: true
  validates :initiative_type, inclusion: { in: INITIATIVE_TYPES }, allow_blank: true

  has_paper_trail
  strip_attributes
end
