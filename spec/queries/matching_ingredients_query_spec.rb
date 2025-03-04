RSpec.describe Recipes::MatchingIngredientsQuery do
  let(:query) { 'egg, milk, flour' }
  let(:relation) { instance_double(ActiveRecord::Relation) }
  let(:query_formatter) { instance_double(Recipes::QueryFormatter, call: formatted_query) }
  let(:query_formatter_class) { class_double(Recipes::QueryFormatter, new: query_formatter) }
  let(:formatted_query) { '"egg" & "milk" & "flour"' }

  subject { described_class.new(query, relation, query_formatter: query_formatter_class) }

  before do
    allow(relation).to receive(:where).and_return(relation)
    allow(relation).to receive(:limit).and_return(relation)
  end

  describe '#call' do
    context 'when the query is present' do
      it 'formats the query correctly' do
        subject.call
        expect(query_formatter).to have_received(:call)
      end

      it 'searches for recipes matching the formatted query' do
        subject.call
        expect(relation).to have_received(:where).with("ingredients_vector @@ websearch_to_tsquery('english', ?)", formatted_query)
      end
    end

    context 'when the query is blank' do
      let(:formatted_query) { '' }

      it 'returns a limited set of recipes' do
        subject.call
        expect(relation).to have_received(:limit).with(10)
      end
    end
  end
end
