module Recipes
  class MatchingIngredientsService

    def initialize(query)
      @query = query
    end

    def call
      formatted_query = format_query(@query)
      ingredients = extract_ingredients(@query)
      matched_ingredients_count = ingredients.count

      if formatted_query.present?
        recipes = Recipe.where("ingredients_vector @@ websearch_to_tsquery('english', ?)", formatted_query)
      else
        recipes = Recipe.limit(10)
      end

      recipes = recipes.map do |recipe|
        total_ingredients_count = recipe.ingredients.length
        hit_percent = calculate_hit_percent(matched_ingredients_count, total_ingredients_count)

        RecipePresenter.new(
          recipe,
          hit_percent,
          matched_ingredients_count,
          total_ingredients_count,
          ingredients
        )
      end

      sort_recipes(recipes)
    end

    private

    def format_query(query)
      query.split(',').map(&:strip).reject(&:empty?).map { |i| %("#{i}") }.join(" & ")
    end

    def extract_ingredients(query)
      query.split(',').map(&:strip).reject(&:empty?)
    end

    def calculate_hit_percent(matched_count, total_count)
      return 0 if total_count.zero?
      (matched_count.to_f / total_count.to_f) * 100
    end

    def sort_recipes(recipes)
      recipes.sort_by { |recipe_presenter| [-recipe_presenter.hit_percent, -recipe_presenter.ratings.to_f] }
    end
  end
end
