require_relative 'living_cell_rules'
require_relative 'dead_cell_rules'

class CellCommunityRules
  attr_reader :living_cells

  def initialize(living_cells)
    @living_cells = living_cells
  end

  def find_living_cells
    @living_cells
  end

  def count_living_cells
    @living_cells.count
  end

  def get_living_cells_coordinates
    coordinates = []
    @living_cells.each{|cell| coordinates << cell.find_living_coordinate}
    coordinates
  end

  def cell_lives_another_generation?(living_cell)
    living_neighbor_count = count_number_of_living_neighbors(living_cell)
    LivingCellRules.stays_alive?(living_neighbor_count)
  end

  def dead_cell_comes_to_life?(dead_cell)
    living_neighbor_count = count_number_of_living_neighbors(dead_cell)
    DeadCellRules.comes_to_life?(living_neighbor_count)
  end

  def count_number_of_living_neighbors(cell)
    identify_living_neighbors_of_cell(cell).count
  end

  def identify_living_neighbors_of_cell(living_cell)
    living_cell.find_living_neighbors(@living_cells)
  end

  def identify_all_possible_dead_neighbors_of_the_living_world
    neighbors = []
    @living_cells.each {|living_cell| neighbors += living_cell.find_dead_neighbors(@living_cells)}
    neighbors.uniq
  end

  def find_dead_neighbors_eligible_for_life
    new_life_to_dead_cells = []
    all_possible_neighbors = identify_all_possible_dead_neighbors_of_the_living_world
    all_possible_neighbors.each do |dead_cell|
      new_life_to_dead_cells << potential_life if dead_cell_comes_to_life?(potential_life)
    end
    new_life_to_dead_cells
  end
end
