module Recipes
  class SortRecipeService
    def self.call(recipes)
      recipes.sort_by { |recipe_presenter| [-recipe_presenter.hit_percent, -recipe_presenter.ratings.to_f] }
    end
  end
end
