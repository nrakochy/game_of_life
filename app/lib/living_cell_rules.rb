class LivingCellRules
  
  def self.stays_alive?(number_of_neighbors)
    number_of_neighbors == 2 || number_of_neighbors == 3
  end
  
end