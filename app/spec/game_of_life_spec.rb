require_relative '../lib/game_of_life'
require_relative '../lib/individual_cell_rules_for_life'
require_relative '../lib/cell_community_rules'

describe World do
  let(:cell1){ [ 1, 1 ] }
  let(:cell2){ [ 2, 1 ] }
  let(:cell3){ [ 1, 2 ] }
  let(:cell4){ [ 3, 1 ] }
  let(:cell5){ [ 4, 1 ] }
  let(:world_with_one_cell){ World.new([cell1])}
  let(:world_with_two_cells){ World.new([cell1, cell2])}
  let(:world_with_three_cells){ World.new([cell1, cell2, cell3]) }
  let(:world_with_four_cells){ World.new([cell1, cell2, cell3, cell4]) }
  let(:world_with_five_cells){ World.new([cell1, cell2, cell3, cell4, cell5]) }

  describe '#create_community_of_living_cells' do
    it 'adds living_cell Object to the living world' do
      expect(world_with_one_cell.living_world.first.class).to eq(LivingCellCoordinate)
      expect(world_with_one_cell.living_world.count).to eq(1)
    end
  end

  describe 'tick_to_next_generation_of_life' do
    context '2 living cells or less' do
      it 'removes all cells, given there is only 2 living cells in the World' do
        expect(world_with_two_cells.tick_to_next_generation_of_life.count).to eq(0)
      end
    end

    context '3 living cells' do
      it 'keeps 3 living cells and adds 1 new cell to the living world' do
        expect(world_with_three_cells.tick_to_next_generation_of_life.count).to eq(4)
      end
    end

    context '4 living cells' do
      it 'keeps 3 living_cells of 4 which should live to the next generation and
      adds a new living cell from the eligible neighbors' do
        expect(world_with_four_cells.tick_to_next_generation_of_life.count).to eq(4)
      end
    end

    context '5 living cells' do
      it 'keeps 4 living_cells of 5 which should live to the next generation and
      adds 3 new living cells from the eligible neighbors' do
        expect(world_with_five_cells.tick_to_next_generation_of_life.count).to eq(7)
      end
    end

  end

    describe '#bring_to_life_all_eligible_neighbors' do
      context 'world with 2 cells or less' do
        it 'returns an empty array with no LivingCells' do
          life_in_the_world = world_with_one_cell.bring_to_life_all_eligible_neighbors
          life_in_the_two_cell_world = world_with_two_cells.bring_to_life_all_eligible_neighbors
          expect(life_in_the_world.count).to eq(0)
          expect(life_in_the_two_cell_world.count).to eq(0)
        end
      end

      context 'world with 3 cells' do
        it 'returns an array with 1 LivingCells' do
          life_in_the_three_cell_world = world_with_three_cells.bring_to_life_all_eligible_neighbors
          expect(life_in_the_three_cell_world.count).to eq(1)
        end
      end

      context 'world with 4 cells' do
        it 'returns an array with 1 new Living Cells' do
          life_in_the_four_cell_world = world_with_four_cells.bring_to_life_all_eligible_neighbors
          expect(life_in_the_four_cell_world.count).to eq(1)
        end
      end

      context 'world with 5 cells' do
        it 'returns an array with 3 new Living Cells' do
          life_in_the_five_cell_world = world_with_five_cells.bring_to_life_all_eligible_neighbors
          expect(life_in_the_five_cell_world.count).to eq(3)
        end
      end

    end
end






