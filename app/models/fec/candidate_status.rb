class Fec::CandidateStatus 
  TYPES = {
    'C' => "Statutory candidate",
    'F' => "Statutory candidate for future election",
    'N' => "Not yet a statutory candidate",
    'P' => "Statutory candidate in prior cycle",
    'Q' => "Type Q" # undocumented
  }
  def method_missing type
    TYPES[type] || TYPE.rassoc(type)[0]
  end
end