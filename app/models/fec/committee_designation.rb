class Fec::CommitteeDesignation
  TYPES = {
    'A' => 'Authorized by a candidate',
    'B' => 'Lobbyist/Registrant PAC',
    'D' => 'Leadership PAC',
    'J' => 'Joint fund raiser',
    'P' => 'Principal campaign committee of a candidate',
    'U' => 'Unauthorized'
  }
  def method_missing type
    TYPES[type] || TYPE.rassoc(type)[0]
  end
end
