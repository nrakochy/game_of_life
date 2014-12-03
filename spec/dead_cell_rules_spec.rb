require_relative '../lib/dead_cell_rules'

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