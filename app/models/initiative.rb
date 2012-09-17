class Initiative < ActiveRecord::Base
  ELECTION_TYPES = %w(Primary General Special)
  INITIATOR_TYPES = %w(Legislature Citizen Commission Automatic)
  INITIATIVE_TYPES = ["Constitutional Amendment", "Statute", "Bond", "Veto", "Question", "Combined Constitutional Amendment & Statute", "Affirmation", "Recall"]
  validates_inclusion_of :election_type, :in => ELECTION_TYPES, :allow_blank => true
  validates_inclusion_of :initiator_type, :in => INITIATOR_TYPES, :allow_blank => true
  validates_inclusion_of :initiative_type, :in => INITIATIVE_TYPES, :allow_blank => true
  
  attr_accessible :jurisdiction, :election_date, :filing_date, :summary_date, :circulation_deadline, :full_check_deadline, :election_type, :initiator_type, :initiative_type, :indirect, :initiative_name, :proposition_name, :title, :informal_title, :short_summary, :summary, :analysis, :text, :wikipedia_url, :ballotpedia_url # but not status
  
  # TODO: Expand once we start doing more than just US states
  JURISDICTIONS = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming", "District of Columbia", "Puerto Rico", "Guam", "American Samoa", "U.S. Virgin Islands", "Northern Mariana Islands"]
  
  
  has_paper_trail
  strip_attributes
end
