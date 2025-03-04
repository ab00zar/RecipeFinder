RSpec.describe Recipes::RecipeFinderService do
  describe '#call' do
    let(:query) { 'apple, banana' }
    let(:ingredient_extractor) { class_double(Recipes::IngredientsExtractorService) }
    let(:recipe_query) { class_double(Recipes::MatchingIngredientsQuery) }
    let(:recipe_sorter) { class_double(Recipes::SortRecipeService) }
    let(:recipe_presenter_factory) { class_double(Recipes::RecipePresenterFactory) }

    let(:service) do
      Recipes::RecipeFinderService.new(
        query,
        ingredient_extractor: ingredient_extractor,
        recipe_query: recipe_query,
        recipe_sorter: recipe_sorter,
        recipe_presenter_factory: recipe_presenter_factory
      )
    end

    let(:extracted_ingredients) { ['apple', 'banana'] }
    let(:matching_recipes) { [instance_double(Recipe), instance_double(Recipe)] }
    let(:presented_recipes) { [instance_double(RecipePresenter), instance_double(RecipePresenter)] }
    let(:sorted_recipes) { presented_recipes.reverse }

    before do
      allow(ingredient_extractor).to receive(:call).with(query).and_return(extracted_ingredients)
      allow(recipe_query).to receive(:new).with(query).and_return(double(call: matching_recipes))
      allow(recipe_presenter_factory).to receive(:new).and_return(double(call: presented_recipes[0]), double(call: presented_recipes[1]))
      allow(recipe_sorter).to receive(:call).with(presented_recipes).and_return(sorted_recipes)
    end

    it 'calls the ingredient extractor, recipe query, presenter factory, and sorter' do
      expect(ingredient_extractor).to receive(:call).with(query)
      expect(recipe_query).to receive(:new).with(query).and_return(double(call: matching_recipes))
      expect(recipe_presenter_factory).to receive(:new).twice
      expect(recipe_sorter).to receive(:call).with(presented_recipes)

      service.call
    end

    it 'returns the sorted recipes' do
      expect(service.call).to eq(sorted_recipes)
    end

    it 'passes the correct arguments to the presenter factory' do
      service.call
      expect(recipe_presenter_factory).to have_received(:new).with(matching_recipes[0], 2, extracted_ingredients)
      expect(recipe_presenter_factory).to have_received(:new).with(matching_recipes[1], 2, extracted_ingredients)
    end
  end
end
