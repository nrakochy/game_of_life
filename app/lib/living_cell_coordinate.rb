require 'pry'
class LivingCellCoordinate
  attr_reader :living_coordinate

  def initialize(location_coordinate)
    @living_coordinate = location_coordinate
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

  def find_living_neighbors(living_cells)
    living_neighbors = []
    all_possible_neighbors = find_all_possible_neighbors
    living_cells.each do |living_cell|
      cell_coordinate = living_cell.find_living_coordinate
       living_neighbors << living_cell if all_possible_neighbors.include?(cell_coordinate)
    end
    living_neighbors
  end

  def find_dead_neighbors(living_cells)
    dead_neighbors = []
    living_coordinates = []
    all_possible_neighbors = find_all_possible_neighbors
    living_cells.each{ |living_cell| living_coordinates << living_cell.find_living_coordinate }
    all_possible_neighbors.each{ |cell_coordinate| dead_neighbors << cell_coordinate if !living_coordinates.include?(cell_coordinate) }
    dead_neighbors
  end

  def find_three_surrounding_axis_coordinates(num)
    [num - 1, num, num + 1]
  end
end
