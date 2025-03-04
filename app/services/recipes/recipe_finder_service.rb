module Recipes
  class RecipeFinderService
    def initialize(
      query,
      ingredient_extractor: Recipes::IngredientsExtractorService,
      recipe_query: Recipes::MatchingIngredientsQuery,
      recipe_sorter: Recipes::SortRecipeService,
      recipe_presenter_factory: Recipes::RecipePresenterFactory
    )
      @query = query
      @ingredient_extractor = ingredient_extractor
      @recipe_query = recipe_query
      @recipe_sorter = recipe_sorter
      @recipe_presenter_factory = recipe_presenter_factory
    end

    def call
      query_ingredients = extract_ingredients
      recipes = find_matching_recipes
      final_results = present_recipes(recipes, query_ingredients)
      sort_recipes(final_results)
    end

    private

    def extract_ingredients
      @ingredient_extractor.call(@query)
    end

    def find_matching_recipes
      @recipe_query.new(@query).call
    end

    def present_recipes(recipes, ingredients)
      matched_ingredients_count = ingredients.count

      recipes.map do |recipe|
        @recipe_presenter_factory.new(recipe, matched_ingredients_count, ingredients).call
      end
    end

    def sort_recipes(recipes)
      @recipe_sorter.call(recipes)
    end
  end
end
