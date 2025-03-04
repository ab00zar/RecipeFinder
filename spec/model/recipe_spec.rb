RSpec.describe Recipe, type: :model do
  describe '#update_ingredients_vector' do
    let(:recipe) { Recipe.create!(ingredients: ['tomato', 'onion']) }

    it 'generates a tsvector for ingredients' do
      recipe.save
      expect(recipe.ingredients_vector).to be_present
    end

    context 'when ingredients are blank' do
      let(:recipe) { Recipe.create!(ingredients: []) }

      it 'does not generate a tsvector' do
        recipe.save
        expect(recipe.ingredients_vector).to be_nil
      end
    end
  end
end
