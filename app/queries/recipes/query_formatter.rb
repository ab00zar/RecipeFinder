module Recipes
  class QueryFormatter
    def initialize(query)
      @query = query.to_s
    end

    def call
      @query.blank? ? "" : format_ingredients
    end

    private

    def format_ingredients
      @query
        .split(',')
        .map(&:strip)
        .reject(&:empty?)
        .map(&:singularize )
        .uniq
        .map { |ingredient| %("#{ingredient}") }
        .join(" & ")
    end
  end
end
