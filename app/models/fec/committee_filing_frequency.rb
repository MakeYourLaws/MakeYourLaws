class Fec::CommitteeFilingFrequency
  TYPES = {
    'A' => 'Administratively terminated',
    'D' => 'Debt',
    'M' => 'Monthly filer',
    'Q' => 'Quarterly filer',
    'T' => 'Terminated',
    'W' => 'Waived',
  }
  def method_missing type
    TYPES[type] || TYPE.rassoc(type)[0]
  end
end