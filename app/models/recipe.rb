class Recipe < ApplicationRecord
  before_save :update_ingredients_vector

  private

  def update_ingredients_vector
    return if ingredients.blank?

    self.ingredients_vector =
      ActiveRecord::Base.connection.execute(
        "SELECT to_tsvector('english', #{ActiveRecord::Base.connection.quote(ingredients.join(' '))})"
      ).first['to_tsvector']
  end
end
