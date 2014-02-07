class Initiative < ActiveRecord::Base
  resourcify
  
  ELECTION_TYPES = %w(Primary General Special)
  INITIATOR_TYPES = %w(Legislature Citizen Commission Automatic)
  INITIATIVE_TYPES = ["Constitutional Amendment", "Statute", "Bond", "Veto", "Question", "Combined Constitutional Amendment & Statute", "Affirmation", "Recall"]
  validates_inclusion_of :election_type, :in => ELECTION_TYPES, :allow_blank => true
  validates_inclusion_of :initiator_type, :in => INITIATOR_TYPES, :allow_blank => true
  validates_inclusion_of :initiative_type, :in => INITIATIVE_TYPES, :allow_blank => true
    
  has_paper_trail
  strip_attributes
end
