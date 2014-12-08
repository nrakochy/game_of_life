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

  describe 'tick_to_next_generation_of_life' do
    it 'keeps 1 living_cell of 3 which should live to the next generation' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      last_cell = @new_world.introduce_life_into_the_world([0,1])
      expect(@new_world.tick_to_next_generation_of_life).to include(first_cell)
      expect(@new_world.tick_to_next_generation_of_life).not_to include(second_cell, last_cell)
    end

    it 'keeps 3 living_cells of 4 which should live to the next generation' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([2,1])
      third_cell = @new_world.introduce_life_into_the_world([1,0])
      last_cell = @new_world.introduce_life_into_the_world([8,1])
      expect(@new_world.tick_to_next_generation_of_life).to include(first_cell, second_cell, third_cell)
      expect(@new_world.tick_to_next_generation_of_life).not_to include(last_cell)
    end

    it 'gives life to a dead cell with 3 living neighbors' do
      first_cell = @new_world.introduce_life_into_the_world([1,1])
      second_cell = @new_world.introduce_life_into_the_world([1,2])
      third_cell = @new_world.introduce_life_into_the_world([2,2])
      last_cell = @new_world.introduce_life_into_the_world([8,1])
      @new_world.tick_to_next_generation_of_life
      expect(@new_world.living_world).not_to include(last_cell)
    end
  end

  describe '#create_living_cell' do
    it 'creates a living_cell_coordinate Object' do
      expect(@new_world.create_living_cell([1,1]).class).to eq(LivingCellCoordinate)
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
end






