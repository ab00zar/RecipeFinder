module Recipes
  class MatchingIngredientsService
    def initialize(query)
      @query = query
    end

    def call
      ingredients = Recipes::IngredientsExtractorService.call(@query)
      matched_ingredients_count = ingredients.count
      recipes = Recipes::MatchingIngredientsQuery.new(@query).call

      recipes = recipes.map do |recipe|
        total_ingredients_count = recipe.ingredients.length
        hit_percent = Recipes::HitCalculatorService.call(matched_ingredients_count, total_ingredients_count)

        RecipePresenter.new(
          recipe,
          hit_percent,
          matched_ingredients_count,
          total_ingredients_count,
          ingredients
        )
      end

      Recipes::SortRecipeService.call(recipes)
    end
  end
end
