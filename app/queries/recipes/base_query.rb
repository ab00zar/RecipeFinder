module Recipes
  class BaseQuery
    def initialize(relation = Recipe.all)
      @relation = relation
    end

    def call
      @relation
    end
  end
end
