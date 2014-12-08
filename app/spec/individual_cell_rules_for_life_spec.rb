require_relative '../lib/individual_cell_rules_for_life'

describe IndividualCellRulesForLife do
  describe '#stays_alive?' do
    it 'returns false if 0 living neighbors' do
      expect(IndividualCellRulesForLife.stays_alive?(0)).to eq(false)
    end

    it 'returns false if 1 living neighbors' do
      expect(IndividualCellRulesForLife.stays_alive?(1)).to eq(false)
    end

    it 'returns true if 2 living neighbors' do
      expect(IndividualCellRulesForLife.stays_alive?(2)).to eq(true)
    end

    it 'returns true if 3 living neighbors' do
      expect(IndividualCellRulesForLife.stays_alive?(3)).to eq(true)
    end

    it 'returns false if given living_cell_coordinate has 4 living neighbors' do
      expect(IndividualCellRulesForLife.stays_alive?(4)).to eq(false)
    end
  end

  describe '#comes_to_life?' do
    it 'returns false if number of living neighbors is 1' do
      expect(IndividualCellRulesForLife.comes_to_life?(1)).to eq(false)
    end

    it 'returns false if number of living neighbors is 2' do
      expect(IndividualCellRulesForLife.comes_to_life?(2)).to eq(false)
    end

    it 'returns true if number of living neighbors is 3' do
      expect(IndividualCellRulesForLife.comes_to_life?(3)).to eq(true)
    end

    it 'returns false if number of living neighbors is 4' do
      expect(IndividualCellRulesForLife.comes_to_life?(4)).to eq(false)
    end
  end

end
