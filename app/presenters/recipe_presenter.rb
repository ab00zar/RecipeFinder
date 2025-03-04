class RecipePresenter < SimpleDelegator
  attr_reader :hit_percent, :matched_count, :total_count, :user_ingredients

  def initialize(recipe, hit_percent, matched_count, total_count, user_ingredients)
    super(recipe)
    @hit_percent = hit_percent
    @matched_count = matched_count
    @total_count = total_count
    @user_ingredients = user_ingredients.map(&:downcase)
  end

  def ingredients_match_text
    "#{matched_count} out of #{total_count}"
  end

  def highlighted_ingredients
    ingredients.map do |ingredient|
      if ingredient_matches?(ingredient)
        "<strong>#{ingredient}</strong>"
      else
        ingredient
      end
    end
  end

  private

  def ingredient_matches?(ingredient)
    user_ingredients.any? do |user_ingredient|
      ingredient.downcase.include?(user_ingredient)
    end
  end
end
