require 'opal'
require 'opal-jquery'
require_relative 'living_cell_coordinate'
require_relative 'cell_community_rules'

class World
  attr_reader :living_world

  def create_empty_world
    @living_world = []
  end

  def introduce_life_into_the_world(living_cell_coordinate)
    living_cell = create_living_cell(living_cell_coordinate)
    @living_world << living_cell
    living_cell
  end

  def tick_to_next_generation_of_life
    new_life_to_dead_cells = bring_to_life_all_eligible_neighbors
    @living_world.keep_if{ |living_cell| cell_lives_another_generation?(living_cell)}
    new_life_to_dead_cells.each{ |living_cell| @living_world << living_cell }
    @living_world
  end

  def bring_to_life_all_eligible_neighbors
    new_life_to_dead_cells = []
    all_possible_neighbors = identify_all_possible_dead_neighbors_of_the_living_world
    all_possible_neighbors.each do |dead_cell|
      potential_life = create_living_cell(dead_cell)
      new_life_to_dead_cells << potential_life if dead_cell_comes_to_life?(potential_life)
    end
    new_life_to_dead_cells
  end


  def cell_lives_another_generation?(living_cell)
    CellCommunityRules.cell_lives_another_generation?(living_neighbor_count, @living_cells)
  end

  def dead_cell_comes_to_life?(dead_cell)
    CellCommunityRules.dead_cell_comes_to_life?(living_neighbor_count, @living_cells)
  end

  def create_living_cell(cell_coordinate)
    LivingCellCoordinate.new(cell_coordinate)
  end
end





