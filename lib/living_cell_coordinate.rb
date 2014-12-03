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

  def find_three_surrounding_axis_coordinates(num)
    [num - 1, num, num + 1]
  end
end