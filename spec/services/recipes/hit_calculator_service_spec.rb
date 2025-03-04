RSpec.describe Recipes::HitCalculatorService do
  describe '.call' do
    context 'when total count is zero' do
      it 'returns 0.0' do
        result = described_class.call(5, 0)
        expect(result).to eq(0.0)
      end

      it 'returns 0.0 when both counts are zero' do
        result = described_class.call(0, 0)
        expect(result).to eq(0.0)
      end
    end

    context 'when all items match' do
      it 'returns 100.0' do
        result = described_class.call(7, 7)
        expect(result).to eq(100.0)
      end
    end

    context 'when some items match' do
      it 'returns the correct percentage for 50%' do
        result = described_class.call(5, 10)
        expect(result).to eq(50.0)
      end

      it 'returns the correct percentage for 75%' do
        result = described_class.call(3, 4)
        expect(result).to eq(75.0)
      end

      it 'handles floating-point precision correctly' do
        expect(described_class.call(1, 3)).to be_within(0.01).of(33.33)
      end
    end

    context 'with decimal inputs' do
      it 'handles both inputs as decimals' do
        result = described_class.call(2.0, 4.0)
        expect(result).to eq(50.0)
      end
    end

    context 'with integer results' do
      it 'returns a float even for whole number percentages' do
        result = described_class.call(5, 10)
        expect(result).to eq(50.0)
        expect(result).to be_a(Float)
      end
    end
  end
end
