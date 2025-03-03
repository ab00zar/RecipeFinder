module Recipes
  class MatchingIngredientsQuery
      def initialize(query)
        @query = query
      end

      def call
        formatted_query = format_query(@query)

        if formatted_query.present?
          Recipe.where("ingredients_vector @@ websearch_to_tsquery('english', ?)", formatted_query)
        else
          Recipe.limit(10)
        end
      end

      private

      def format_query(query)
        query.split(',').map(&:strip).reject(&:empty?).map { |i| %("#{i}") }.join(" & ")
      end
  end
end
