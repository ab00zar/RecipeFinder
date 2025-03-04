RSpec.describe Recipes::SortRecipeService do
  describe '.call' do
    let(:recipe1) { double('RecipePresenter', hit_percent: 80.0, ratings: 4.5) }
    let(:recipe2) { double('RecipePresenter', hit_percent: 90.0, ratings: 4.0) }
    let(:recipe3) { double('RecipePresenter', hit_percent: 80.0, ratings: 4.8) }
    let(:recipe4) { double('RecipePresenter', hit_percent: 70.0, ratings: 5.0) }

    it 'sorts recipes by hit_percent in descending order' do
      sorted_recipes = described_class.call([recipe1, recipe2, recipe3, recipe4])

      expect(sorted_recipes).to eq([recipe2, recipe3, recipe1, recipe4])
    end

    it 'sorts recipes with the same hit_percent by ratings in descending order' do
      sorted_recipes = described_class.call([recipe1, recipe3])

      expect(sorted_recipes).to eq([recipe3, recipe1])
    end

    it 'returns an empty array when given an empty array' do
      expect(described_class.call([])).to eq([])
    end

    it 'returns the same array when there is only one recipe' do
      expect(described_class.call([recipe1])).to eq([recipe1])
    end
  end
end
