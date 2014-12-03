require_relative '../lib/living_cell_coordinate'

describe LivingCellCoordinate do
  describe '#intialize' do
    it 'assigns a location coordinate upon initialization' do
      new_cell = LivingCellCoordinate.new([1,1])
      expect(new_cell.living_coordinate).to eq([1,1])
    end
  end

  describe '#find_all_possible_neighbors' do
    it 'finds all possible neighbors for a given coordinate' do
      new_cell = LivingCellCoordinate.new([1,1])
      expect(new_cell.find_all_possible_neighbors).to eq([
      [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 1, 0 ],  [ 1, 2], [ 2, 0 ], [ 2, 1], [ 2, 2 ]
      ])
    end
  end

  describe '#find_living_coordinate' do
    it 'returns the living_coordinate attribute from the cell' do
      new_cell = LivingCellCoordinate.new([1,1])
      expect(new_cell.find_living_coordinate).to eq([1,1])
    end
  end


  describe '#find_surrounding_axis_coordinate' do
    it 'returns an array of the 3 numbers on the plane of a given number' do
      new_cell = LivingCellCoordinate.new([1,1])
      expect(new_cell.find_three_surrounding_axis_coordinates(1)).to eq([ 0, 1, 2 ])
    end
  end
end