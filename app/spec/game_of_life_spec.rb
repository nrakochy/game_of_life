require_relative '../lib/game_of_life'
require_relative '../lib/individual_cell_rules_for_life'
require_relative '../lib/cell_community_rules'

describe World do
  let(:cell1){ [ 1, 1 ] }
  let(:cell2){ [ 2, 1 ] }
  let(:cell3){ [ 1, 2 ] }
  let(:cell4){ [ 3, 1 ] }
  let(:world_with_two_cells){ World.new([cell1, cell2])}
  let(:world_with_three_cells){ World.new([cell1, cell2, cell3]) }
  let(:world_with_four_cells){ World.new([cell1, cell2, cell3, cell4]) }

  describe '#create_community_of_living_cells' do
    it 'adds living_cell Object to the living world' do
      new_world = World.new([ [ 1, 1 ] ])
      expect(new_world.living_world.first.class).to eq(LivingCellCoordinate)
      expect(new_world.living_world.count).to eq(1)
    end
  end

  describe 'tick_to_next_generation_of_life' do
    context '2 living cells or less' do
      it 'removes all cells, given there is only 2 living cells in the World' do
        expect(world_with_two_cells.tick_to_next_generation_of_life.count).to eq(0)
      end
    end

    context '3 living cells' do
      it 'keeps 3 living cells and adds 1 dead cell to the living world' do
        expect(world_with_three_cells.tick_to_next_generation_of_life.count).to eq(4)
      end
    end

    xit 'keeps 3 living_cells of 4 which should live to the next generation' do
      expect(world_with_four_cells.tick_to_next_generation_of_life.count).to eq(3)
    end

    xit 'gives life to a dead cell with 3 living neighbors' do
      expect(new_world.living_world).not_to include(last_cell)
    end
  end

  describe '#create_living_cell' do
    it 'creates a living_cell_coordinate Object' do
      expect(new_world.create_living_cell([1,1]).class).to eq(LivingCellCoordinate)
    end
  end

    describe '#bring_to_life_all_eligible_neighbors' do
    it 'returns an empty array if no dead cells come to life' do
      first_cell = new_world.introduce_life_into_the_world([1,1])
      expect(new_world.bring_to_life_all_eligible_neighbors.empty?).to eq(true)
    end

    it 'creates life for 1 dead cell with 3 living neighbors' do
      first_cell = new_world.introduce_life_into_the_world([1,1])
      second_cell = new_world.introduce_life_into_the_world([1,2])
      third_cell = new_world.introduce_life_into_the_world([2,2])
      expect(new_world.bring_to_life_all_eligible_neighbors.count).to eq(1)
      expect(new_world.bring_to_life_all_eligible_neighbors.first.class).to eq(LivingCellCoordinate)
      expect(new_world.bring_to_life_all_eligible_neighbors.first.find_living_coordinate).to eq([2,1])
    end
  end
end

def find_cell_coordinate(cell)
  cell.find_living_coordinate
end





