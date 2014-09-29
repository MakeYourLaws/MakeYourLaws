class Fec::CommitteeInterestGroupCategory
  TYPES = {
    'C' => 'Corporation',
    'L' => 'Labor organization',
    'M' => 'Membership organization',
    'T' => 'Trade association',
    'V' => 'Cooperative',
    'W' => 'Corporation without capital stock',
    'O' => 'Other', # undocumented
  }
  def method_missing type
    TYPES[type] || TYPE.rassoc(type)[0]
  end
end
