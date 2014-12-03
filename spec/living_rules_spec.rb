require_relative '../lib/living_cell_rules'

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
