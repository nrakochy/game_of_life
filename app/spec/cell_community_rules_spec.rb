require_relative '../lib/cell_community_rules'
require_relative '../lib/living_cell_coordinate'

describe CellCommunityRules do

  before(:each) do
    first_cell = [ 1 , 1 ]
    second_cell = [ 2 , 1 ]
    third_cell = [ 1 , 2 ]
    fourth_cell = [ 3, 1 ]
    five_cell = [ 4 , 1 ]
    @cell1 = LivingCellCoordinate.new(first_cell)
    @cell2 = LivingCellCoordinate.new(second_cell)
    @cell3 = LivingCellCoordinate.new(third_cell)
    @cell4 = LivingCellCoordinate.new(fourth_cell)
    @cell5 = LivingCellCoordinate.new(five_cell)
    @rules_empty_world = CellCommunityRules.new([])
    @rules_world_with_one_cell = CellCommunityRules.new([@cell1])
    @rules_world_with_two_cells = CellCommunityRules.new([@cell1, @cell2])
    @rules_world_with_three_cells = CellCommunityRules.new([@cell1, @cell2, @cell3])
    @rules_world_with_four_cells = CellCommunityRules.new([@cell1, @cell2, @cell3, @cell4])
    @rules_world_with_five_cells = CellCommunityRules.new([@cell1, @cell2, @cell3, @cell4, @cell5])
  end

  describe '#count_number_of_living_neighbors' do
    it 'returns 1 for a living cell with 1 neighbor' do
      expect(@rules_world_with_two_cells.count_number_of_living_neighbors(@cell1)).to eq(1)
    end

    it 'returns an array with 2 cells from the living_world for a cell with 2 neighbor' do
      expect(@rules_world_with_three_cells.count_number_of_living_neighbors(@cell1)).to eq(2)
    end
  end

  describe '#cell_lives_another_generation?' do
   it 'returns false if a cell has only 1 neighbor' do
      expect(@rules_world_with_two_cells.cell_lives_another_generation?(@cell1)).to eq(false)
    end

   it 'returns true if a cell has two neighbors' do
      expect(@rules_world_with_three_cells.cell_lives_another_generation?(@cell1)).to eq(true)
    end
  end

  describe '#identify_living_neighbors_of_cell' do
    it 'returns 1 cell for a cell with 1 neighbor' do
      expect(@rules_world_with_two_cells.identify_living_neighbors_of_cell(@cell1)).to eq([@cell2])
    end

    it 'returns 2 cells for a cell with 2 neighbors' do
      expect(@rules_world_with_three_cells.identify_living_neighbors_of_cell(@cell1)).to contain_exactly(@cell2, @cell3)
    end
  end

  describe '#dead_cell_comes_to_life?' do
    it 'returns false if a cell has 2 neighbors' do
      dead_cell = [0,0]
      expect(@rules_world_with_two_cells.dead_cell_comes_to_life?(dead_cell)).to eq(false)
    end

    it 'returns true if a cell has 3 neighbors' do
      dead_cell = [2,2]
      expect(@rules_world_with_three_cells.dead_cell_comes_to_life?(dead_cell)).to eq(true)
    end

    it 'returns false if a cell has four neighbors' do
      dead_cell = [2,2]
      expect(@rules_world_with_four_cells.dead_cell_comes_to_life?(dead_cell)).to eq(false)
    end
  end

  describe '#find_dead_neighbors_eligible_for_life' do
    it 'returns 1 cell coordinate which is to come alive in the next generation for world with 3 cells' do
      expect(@rules_world_with_three_cells.find_dead_neighbors_eligible_for_life).to include([2,2])
    end

    it 'returns 2 cell coordinates which are to come alive in the next generation for world with 5 cells' do
      expect(@rules_world_with_five_cells.find_dead_neighbors_eligible_for_life).to include([3,2])
      expect(@rules_world_with_five_cells.find_dead_neighbors_eligible_for_life).to include([2,0])
      expect(@rules_world_with_five_cells.find_dead_neighbors_eligible_for_life).to include([3,0])
      expect(@rules_world_with_five_cells.find_dead_neighbors_eligible_for_life).not_to include([2,2])
    end
  end
end





