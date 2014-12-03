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
    it 'keeps 1 living_cell of 3 which should live to the next generation' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.entropy_tick_to_next_generation_of_life).to include(first_cell)
      expect(@new_world.entropy_tick_to_next_generation_of_life).not_to include(second_cell, last_cell)
    end

    it 'keeps 3 living_cells of 4 which should live to the next generation' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      third_cell = @new_world.introduce_life_into_the_world([1,0])
      last_cell = @new_world.introduce_life_into_the_world([8,1])
      expect(@new_world.entropy_tick_to_next_generation_of_life).to include(first_cell, second_cell, third_cell)
      expect(@new_world.entropy_tick_to_next_generation_of_life).not_to include(last_cell)
    end

    it 'gives life to a dead cell with 3 living neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([1,2])
      third_cell = @new_world.introduce_life_into_the_world([2,2])
      last_cell = @new_world.introduce_life_into_the_world([8,1])
      @new_world.entropy_tick_to_next_generation_of_life
      expect(@new_world.living_world).not_to include(last_cell)
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

  describe '#identify_all_possible_neighbors_of_the_living_world' do
    it 'returns an array with all possible neighbors for the living_world of 1 living cell' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      expect(@new_world.identify_all_possible_dead_neighbors_of_the_living_world).to eq([
       [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 1, 0 ],  [ 1, 2], [ 2, 0 ], [ 2, 1], [ 2, 2 ]
      ])
    end

    it 'returns an array with unique possible neighbors for the living_world of 2 living cells' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,2])
      expect(@new_world.identify_all_possible_dead_neighbors_of_the_living_world).to eq([
       [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 1, 0 ], [ 1, 2], [ 2, 0 ], [ 2, 1],
       [ 1, 3 ], [ 2, 3 ], [ 3, 1 ], [ 3, 2 ], [ 3, 3]
      ])
    end
  end

  describe '#bring_to_life_all_eligible_neighbors' do
    it 'returns an empty array if no dead cells come to life' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      expect(@new_world.bring_to_life_all_eligible_neighbors.empty?).to eq(true)
    end

    it 'creates life for 1 dead cell with 3 living neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([1,2])
      third_cell = @new_world.introduce_life_into_the_world([2,2])
      expect(@new_world.bring_to_life_all_eligible_neighbors.count).to eq(1)
      expect(@new_world.bring_to_life_all_eligible_neighbors.first.class).to eq(LivingCellCoordinate)
      expect(@new_world.bring_to_life_all_eligible_neighbors.first.find_living_coordinate).to eq([2,1])
    end
  end

  describe '#find_all_coordinates_of_the_living' do
    it 'returns an array with 2 cells from the living_world for a cell with 2 neighbor' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      expect(@new_world.find_all_coordinates_of_the_living).to include([1,1])
    end

    it 'returns an array with the coordinates of two living cells' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.find_all_coordinates_of_the_living).to include([ 1, 1], [ 0, 1])
    end
  end


  describe '#number_of_living_neighbors' do
    it 'counts the number of living_neighbors in the array' do
      expect(@new_world.number_of_living_neighbors([1,2,3])).to eq(3)
    end
  end

  describe '#dead_cell_comes_to_life?' do
   it 'returns false if a cell has less than two neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      dead_cell = @new_world.create_living_cell([0,0])
      expect(@new_world.dead_cell_comes_to_life?(dead_cell)).to eq(false)
    end

    it 'returns true if a cell has two neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      dead_cell = @new_world.create_living_cell([1,2])
      expect(@new_world.cell_lives_another_generation?(dead_cell)).to eq(true)
    end
  end

end






