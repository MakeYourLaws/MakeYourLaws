class Fec::CandidateIncumbent
  TYPES = {
    'C' => "Challenger",
    'I' => "Incumbent",
    'O' => "Open Seat", # seats where the incumbent never sought re-election. There can be cases where an incumbent is defeated in the primary election. In these cases there will be two or more challengers in the general election.
  }
  def method_missing type
    TYPES[type] || TYPE.rassoc(type)[0]
  end
end