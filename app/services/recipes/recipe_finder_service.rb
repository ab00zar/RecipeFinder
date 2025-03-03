module Recipes
  class RecipeFinderService
    def initialize(
      query,
      ingredient_extractor: Recipes::IngredientsExtractorService,
      recipe_query: Recipes::MatchingIngredientsQuery,
      hit_calculator: Recipes::HitCalculatorService,
      recipe_sorter: Recipes::SortRecipeService,
      recipe_presenter: RecipePresenter
    )
      @query = query
      @ingredient_extractor = ingredient_extractor
      @recipe_query = recipe_query
      @hit_calculator = hit_calculator
      @recipe_sorter = recipe_sorter
      @recipe_presenter = recipe_presenter
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
        total_ingredients_count = recipe.ingredients.count
        hit_percent = @hit_calculator.call(matched_ingredients_count, total_ingredients_count)

        @recipe_presenter.new(
          recipe,
          hit_percent,
          matched_ingredients_count,
          total_ingredients_count,
          ingredients
        )
      end
    end

    def sort_recipes(recipes)
      @recipe_sorter.call(recipes)
    end
  end
end
