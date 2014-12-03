require_relative '../lib/game_of_life'

describe World do

  before(:each) do
    new_world = World.new
    new_world.create_empty_world
    @new_world = new_world
  end

  describe '#create_empty_world' do
    it 'creates an empty living world' do
      expect(@new_world.living_world.empty?).to be(true)
    end
  end

  describe '#introduce_life_into_the_world' do
    it 'adds living_cell_coordinate Object to the living world' do
      @new_world.introduce_life_into_the_world([1,1])
      expect(@new_world.living_world.first.class).to eq(LivingCellCoordinate)
      expect(@new_world.living_world.count).to eq(1)
    end
  end

  describe 'entropy_tick_to_next_generation_of_life' do
    it 'keeps a living_cell which should live to the next generation' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.entropy_tick_to_next_generation_of_life).to include(first_cell)
      expect(@new_world.entropy_tick_to_next_generation_of_life).not_to include(second_cell, last_cell)
    end
  end

  describe '#create_living_cell' do
    it 'creates a living_cell_coordinate Object' do
      expect(@new_world.create_living_cell([1,1]).class).to eq(LivingCellCoordinate)
    end
  end

  describe '#count_number_of_living_neighbors' do
    it 'returns 1 for a living cell with 1 neighbor' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.count_number_of_living_neighbors(first_cell)).to eq(1)
    end

    it 'returns an array with 2 cells from the living_world for a cell with 2 neighbor' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.count_number_of_living_neighbors(first_cell)).to eq(2)
    end
  end

  describe '#cell_lives_another_generation?' do
   it 'returns false if a cell has less than two neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      expect(@new_world.cell_lives_another_generation?(first_cell)).to eq(false)
    end

    it 'returns true if a cell has two neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.cell_lives_another_generation?(first_cell)).to eq(true)
    end
  end

  describe '#identify_living_neighbors_of_cell' do
    it 'returns an array with 1 cell the living_world for a cell with 1 neighbor' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.identify_living_neighbors_of_cell(first_cell)).to eq([last_cell])
    end

    it 'returns an array with 2 cells from the living_world for a cell with 2 neighbor' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.identify_living_neighbors_of_cell(first_cell)).to contain_exactly(second_cell, last_cell)
    end
  end

  describe '#number_of_living_neighbors' do
    it 'counts the number of living_neighbors in the array' do
      expect(@new_world.number_of_living_neighbors([1,2,3])).to eq(3)
    end
  end
end

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

describe LivingCellRules do
  describe '#stays_alive?' do
    it 'returns false if 0 living neighbors' do
      expect(LivingCellRules.stays_alive?(0)).to eq(false)
    end

    it 'returns false if 1 living neighbors' do
      expect(LivingCellRules.stays_alive?(1)).to eq(false)
    end

    it 'returns true if 2 living neighbors' do
      expect(LivingCellRules.stays_alive?(2)).to eq(true)
    end

    it 'returns true if 3 living neighbors' do
      expect(LivingCellRules.stays_alive?(3)).to eq(true)
    end

    it 'returns false if given living_cell_coordinate has 4 living neighbors' do
      expect(LivingCellRules.stays_alive?(4)).to eq(false)
    end
  end
end

describe DeadCellRules do
  describe '#comes_to_life?' do
    it 'returns false if number of living neighbors is 1' do
      expect(DeadCellRules.comes_to_life?(1)).to eq(false)
    end

    it 'returns false if number of living neighbors is 2' do
      expect(DeadCellRules.comes_to_life?(2)).to eq(false)
    end

    it 'returns true if number of living neighbors is 3' do
      expect(DeadCellRules.comes_to_life?(3)).to eq(true)
    end

    it 'returns false if number of living neighbors is 4' do
      expect(DeadCellRules.comes_to_life?(4)).to eq(false)
    end
  end
end


