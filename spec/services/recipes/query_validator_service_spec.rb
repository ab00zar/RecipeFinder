RSpec.describe Recipes::QueryValidatorService do
  describe '#validate!' do
    context 'when the query is valid' do
      it 'does not raise an error' do
        validator = described_class.new('chicken, potatoes, onions')
        expect { validator.validate! }.not_to raise_error
      end

      it 'handles queries with letters' do
        validator = described_class.new('abc def ghi')
        expect { validator.validate! }.not_to raise_error
      end

      it 'handles queries with spaces and commas' do
        validator = described_class.new('   chicken,  potatoes,onions  ')
        expect { validator.validate! }.not_to raise_error
      end
    end

    context 'when the query is invalid' do
      it 'raises ArgumentError when the query is nil' do
        validator = described_class.new(nil)
        expect { validator.validate! }.to raise_error(ArgumentError, 'Query cannot be nil')
      end

      it 'raises ArgumentError when the query is not a string' do
        validator = described_class.new(123)
        expect { validator.validate! }.to raise_error(ArgumentError, 'Query must be a string')
      end

      it 'raises ArgumentError when the query contains invalid characters' do
        validator = described_class.new('chicken @ potatoes')
        expect { validator.validate! }.to raise_error(ArgumentError, 'Query contains invalid characters')
      end

      it 'raises ArgumentError when the query is too long' do
        long_query = 'a' * 501
        validator = described_class.new(long_query)
        expect { validator.validate! }.to raise_error(ArgumentError, 'Query is too long')
      end

      it 'raises ArgumentError when the query contains special characters' do
        validator = described_class.new('chicken%potatoes')
        expect { validator.validate! }.to raise_error(ArgumentError, 'Query contains invalid characters')
      end
    end
  end
end
