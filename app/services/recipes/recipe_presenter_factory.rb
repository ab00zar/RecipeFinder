module Recipes
  class RecipePresenterFactory
    def initialize(
      recipe,
      matched_count,
      ingredients,
      hit_calculator: Recipes::HitCalculatorService,
      recipe_presenter: RecipePresenter
    )
      @recipe = recipe
      @matched_count = matched_count
      @ingredients = ingredients
      @hit_calculator = hit_calculator
      @recipe_presenter = recipe_presenter
    end

    def call
      @recipe_presenter.new(
        @recipe,
        hit_percent,
        @matched_count,
        total_ingredients_count,
        @ingredients
      )
    end

    private

    def total_ingredients_count
      @recipe.ingredients.count
    end

    def hit_percent
      @hit_calculator.call(@matched_count, total_ingredients_count)
    end
  end
end
