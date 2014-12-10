require_relative 'living_cell_coordinate'
require_relative 'cell_community_rules'

class World
  attr_reader :living_world, :cell_community_rules

  def initialize(living_world_coordinates)
    @living_world = create_community_of_living_cells(living_world_coordinates)
    @cell_community_rules = find_community_rules(@living_world)
  end

  def tick_to_next_generation_of_life
    new_life_to_dead_cells = bring_to_life_all_eligible_neighbors
    @living_world = keep_alive_all_eligible_living_cells
    new_life_to_dead_cells.each{ |living_cell| @living_world << living_cell }
    @cell_community_rules = find_community_rules(@living_world)
    @living_world
  end

  def keep_alive_all_eligible_living_cells
    @cell_community_rules.keep_alive_all_eligible_living_cells
  end

  def bring_to_life_all_eligible_neighbors
    dead_eligible_for_life = @cell_community_rules.find_dead_neighbors_eligible_for_life
    create_community_of_living_cells(dead_eligible_for_life)
  end

  def count_living_cells
    @living_world.count
  end


  private

  def create_living_cell(cell_coordinate)
    LivingCellCoordinate.new(cell_coordinate)
  end

  def create_community_of_living_cells(living_cell_community)
    community = []
    living_cell_community.each do |cell_coordinate|
      new_cell = create_living_cell(cell_coordinate)
      community << new_cell
    end
    community
  end

  def find_community_rules(living_cell_community)
    CellCommunityRules.new(living_cell_community)
  end

  def find_cell_coordinate(cell)
    cell.find_living_coordinate
  end
end





