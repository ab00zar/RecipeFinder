RSpec.describe Recipes::IngredientsExtractorService do
  describe '.call' do
    it 'splits a comma-separated string into an array' do
      expect(described_class.call('tomato, onion, garlic')).to eq(['tomato', 'onion', 'garlic'])
    end

    it 'removes extra spaces around ingredients' do
      expect(described_class.call('  tomato ,  onion  ,garlic ')).to eq(['tomato', 'onion', 'garlic'])
    end

    it 'removes empty entries' do
      expect(described_class.call('tomato, , onion, , ')).to eq(['tomato', 'onion'])
    end

    it 'returns an empty array when given an empty string' do
      expect(described_class.call('')).to eq([])
    end

    it 'handles a single ingredient correctly' do
      expect(described_class.call('onion')).to eq(['onion'])
    end

    it 'handles a single ingredient correctly' do
      expect(described_class.call('onion')).to eq(['onion'])
    end

    context 'when having multi word ingredients' do
      it 'handles a single multi-word ingredient' do
        expect(described_class.call('olive oil')).to eq(['olive oil'])
      end

      it 'handles a mix of one-word and multi-word ingredients' do
        expect(described_class.call('olive oil, egg, milk')).to eq(['olive oil', 'egg', 'milk'])
      end
    end
  end
end
