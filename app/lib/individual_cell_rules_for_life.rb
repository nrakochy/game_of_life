class IndividualCellRulesForLife

  def self.stays_alive?(number_of_neighbors)
    number_of_neighbors == 2 || number_of_neighbors == 3
  end

  def self.comes_to_life?(number_of_neighbors)
    number_of_neighbors == 3
  end

end
