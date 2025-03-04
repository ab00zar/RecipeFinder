module Recipes
  class MatchingIngredientsQuery < BaseQuery
    def initialize(query, relation = Recipe.all, query_formatter: Recipes::QueryFormatter)
      @query = query
      @query_formatter = query_formatter
      super(relation)
    end

    def call
      @relation.where("ingredients_vector @@ websearch_to_tsquery('english', ?)", formatted_query)
    end

    private

    def formatted_query
      @formatted_query ||= @query_formatter.new(@query).call
    end
  end
end
