class CellCommunityRules
  attr_reader :living_cells

  def initialize(living_cells)
    @living_cells = living_cells
  end

  def cell_lives_another_generation?(living_cell)
    living_neighbor_count = count_number_of_living_neighbors(living_cell)
    stays_alive?(living_neighbor_count)
  end

  def keep_alive_all_eligible_living_cells
    eligible_for_life = []
    @living_cells.each do |living_cell|
      eligible_for_life << living_cell if cell_lives_another_generation?(living_cell)
    end
    eligible_for_life
  end

  def dead_cell_comes_to_life?(dead_cell)
    cell = LivingCellCoordinate.new(dead_cell)
    living_neighbor_count = count_number_of_living_neighbors(cell)
    comes_to_life?(living_neighbor_count)
  end

  def count_number_of_living_neighbors(cell)
    identify_living_neighbors_of_cell(cell).count
  end

  def identify_living_neighbors_of_cell(cell)
     cell.find_living_neighbors(@living_cells)
  end

  def find_dead_neighbors_eligible_for_life
    new_life_to_dead_cells = []
    @living_cells.each do |living_cell|
      dead_neighbors = living_cell.find_dead_neighbors(@living_cells)
      dead_neighbors.each do |potential_life|
        new_life_to_dead_cells << potential_life if dead_cell_comes_to_life?(potential_life)
      end
    end
    new_life_to_dead_cells.uniq
  end

  def stays_alive?(living_neighbor_count)
    living_neighbor_count == 2 || living_neighbor_count == 3
  end

  def comes_to_life?(living_neighbor_count)
    living_neighbor_count == 3
  end
end
