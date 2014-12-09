require 'pry'
require 'opal'
require 'opal-jquery'
require_relative 'living_cell_coordinate'
require_relative 'cell_community_rules'

class World
  attr_reader :living_world, :cell_community_rules

  def initialize(living_world_coordinates)
    @living_world = create_community_of_living_cells(living_world_coordinates)
    @cell_community_rules = CellCommunityRules.new(@living_world)
  end

  def add_living_cell_to_living_world(living_cell)
    @living_world << living_cell
  end

  def tick_to_next_generation_of_life
    new_life_to_dead_cells = bring_to_life_all_eligible_neighbors
    @living_world.keep_if{ |living_cell| cell_lives_another_generation?(living_cell)}
    new_life_to_dead_cells.each{ |living_cell| @living_world << living_cell }
    @living_world
  end

  def bring_to_life_all_eligible_neighbors
    dead_eligible_for_life = @cell_community_rules.find_dead_neighbors_eligible_for_life
    dead_eligible_for_life.each do |dead_cell|
      new_cell = create_living_cell(dead_cell)
      @living_world << new_cell
    end
    @living_world
  end


  def cell_lives_another_generation?(living_cell)
    @cell_community_rules.cell_lives_another_generation?(living_cell)
  end

  def dead_cell_comes_to_life?(dead_cell)
    @cell_community_rules.dead_cell_comes_to_life?(living_neighbor_count, @living_cells)
  end

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
end





