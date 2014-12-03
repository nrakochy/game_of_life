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

  def entropy_tick_to_next_generation_of_life
    @living_world.keep_if{|living_cell| cell_lives_another_generation?(living_cell)}
  end

  def cell_lives_another_generation?(living_cell)
    living_neighbor_count = count_number_of_living_neighbors(living_cell)
    LivingCellRules.stays_alive?(living_neighbor_count)
  end

  def dead_cell_comes_to_life?(dead_cell)
    living_neighbor_count = count_number_of_living_neighbors(dead_cell)
    LivingCellRules.comes_to_life?(living_neighbor_count)
  end

  def count_number_of_living_neighbors(cell)
    living_neighbors = identify_living_neighbors_of_cell(cell)
    number_of_living_neighbors(living_neighbors)
  end

  def identify_living_neighbors_of_cell(living_cell)
    living_neighbors = []
    all_possible_neighbors = living_cell.find_all_possible_neighbors
    @living_world.each do |cell_from_the_living_world|
      cell_location = cell_from_the_living_world.find_living_coordinate
      living_neighbors << cell_from_the_living_world if all_possible_neighbors.include?(cell_location)
    end
    living_neighbors
  end

  def number_of_living_neighbors(living_neighbors)
    living_neighbors.count
  end

  def identify_all_possible_neighbors_of_the_living_world
    all_possible_neighbors = []
    cell_set_of_neighbors = []
    @living_world.each{|living_cell| cell_set_of_neighbors = living_cell.find_all_possible_neighbors }
    cell_set_of_neighbors.each{|potential_neighbor| all_possible_neighbors << potential_neighbor }
    all_possible_neighbors
  end

  def check_all_possible_neighbors_for_the_dead_coming_to_life
    new_life_to_dead_cells = []
    all_possible_neighbors = identify_all_possible_neighbors_of_the_living_world
    all_possible_neighbors.each{|dead_cell| new_life_to_dead_cells << dead_cell if dead_cell_comes_to_life?(dead_cell)}
  end

  def create_living_cell(cell_coordinate)
    LivingCellCoordinate.new(cell_coordinate)
  end
end

class LivingCellCoordinate
  attr_reader :living_coordinate

  def initialize(given_coordinate)
    @living_coordinate = given_coordinate
  end

  def find_living_coordinate
    @living_coordinate
  end

  def find_all_possible_neighbors
    given_coordinate = @living_coordinate
    neighbors = []
    x_axis_numbers = find_three_surrounding_axis_coordinates(given_coordinate.first)
    y_axis_numbers = find_three_surrounding_axis_coordinates(given_coordinate.last)
    x_axis_numbers.each{|x_num| y_axis_numbers.each{|y_num| neighbors << [x_num, y_num]}}
    neighbors.delete(@living_coordinate)
    neighbors
  end

  def find_three_surrounding_axis_coordinates(num)
    [num - 1, num, num + 1]
  end
end

class LivingCellRules
  def self.stays_alive?(number_of_neighbors)
    number_of_neighbors == 2 || number_of_neighbors == 3
  end
end

class DeadCellRules
  def self.comes_to_life?(number_of_neighbors)
    number_of_neighbors == 3
  end
end




