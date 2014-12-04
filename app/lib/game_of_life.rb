require 'pry'
require 'opal'
require 'opal-jquery'
require_relative 'living_cell_coordinate'
require_relative 'dead_cell_rules'
require_relative 'living_cell_rules'

class World
  attr_reader :living_world
  END_OF_THE_WORLD = 35000

  def play_the_game_of_life
    life_cycles = 0
    starting_point = [
      [ 1, 2 ], [ 1, 1 ], [ 2, 2 ], [ 2, 1 ], [ 0, 0 ], [ 0, 1 ], [ 0, 2 ]
    ]
    starting_point.each{|coordinate| introduce_life_into_the_world(coordinate)}
    while life_cycles <= END_OF_THE_WORLD
      tick_to_next_generation_of_life
      puts "Number of living cells: #{count_the_living}"
      life_cycles += 1
    end
  end

  def create_empty_world
    @living_world = []
    self
  end

  def introduce_life_into_the_world(living_cell_coordinate)
    living_cell = create_living_cell(living_cell_coordinate)
    @living_world << living_cell
    living_cell
  end

  def count_the_living
    @living_world.count
  end

  def tick_to_next_generation_of_life
    new_life_to_dead_cells = bring_to_life_all_eligible_neighbors
    @living_world.keep_if{ |living_cell| cell_lives_another_generation?(living_cell)}
    new_life_to_dead_cells.each{ |living_cell| @living_world << living_cell }
    @living_world
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
    living_cell.find_living_neighbors(@living_world)
  end

  def identify_all_possible_dead_neighbors_of_the_living_world
    neighbors = []
    @living_world.each do |living_cell|
      neighbors += living_cell.find_dead_neighbors(@living_world)
    end
    neighbors.uniq
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

  def create_living_cell(cell_coordinate)
    LivingCellCoordinate.new(cell_coordinate)
  end
end





