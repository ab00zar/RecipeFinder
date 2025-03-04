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
      validate_query!
      query_ingredients = extract_ingredients
      recipes = find_matching_recipes
      final_results = present_recipes(recipes, query_ingredients)
      sort_recipes(final_results)
    end

    private

    def validate_query!
      raise ArgumentError, "Query cannot be nil" if @query.nil?
      raise ArgumentError, "Query must be a string" unless @query.is_a?(String)
      raise ArgumentError, "Query contains invalid characters" if @query.match?(/[^a-zA-Z0-9\s,]/)
      raise ArgumentError, "Query is too long" if @query.length > 500
    end

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
