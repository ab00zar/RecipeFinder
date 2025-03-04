RSpec.describe Recipes::RecipePresenterFactory do
  let(:recipe) { double('Recipe', ingredients: ['egg', 'flour', 'milk']) }
  let(:ingredients) { ['egg', 'milk'] }
  let(:matched_count) { 2 }

  describe '.call' do
    it 'creates a RecipePresenter with correct values' do
      presenter = described_class.new(recipe, matched_count, ingredients).call

      expect(presenter).to be_a(RecipePresenter)
      expect(presenter.hit_percent).to be_within(0.01).of(66.66)
      expect(presenter.matched_count).to eq(2)
      expect(presenter.total_count).to eq(3)
      expect(presenter.user_ingredients).to eq(ingredients)
    end
  end
end
