class Initiative < ActiveRecord::Base
  ELECTION_TYPES = %w(Primary General Special)
  INITIATOR_TYPES = %w(Legislature Citizen Commission Automatic)
  INITIATIVE_TYPES = ["Constitutional Amendment", "Statute", "Bond", "Veto", "Question", "Combined Constitutional Amendment & Statute", "Affirmation", "Recall"]
  validates_inclusion_of :election_type, :in => ELECTION_TYPES, :allow_blank => true
  validates_inclusion_of :initiator_type, :in => INITIATOR_TYPES, :allow_blank => true
  validates_inclusion_of :initiative_type, :in => INITIATIVE_TYPES, :allow_blank => true
  
  attr_accessible :jurisdiction, :election_date, :filing_date, :summary_date, :circulation_deadline, :full_check_deadline, :election_type, :initiator_type, :initiative_type, :indirect, :initiative_name, :proposition_name, :title, :informal_title, :short_summary, :summary, :analysis, :text, :wikipedia_url, :ballotpedia_url # but not status
  
  has_paper_trail
  strip_attributes
end
