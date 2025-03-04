module Recipes
  class QueryValidatorService
    def initialize(query)
      @query = query
    end

    def validate!
      raise ArgumentError, "Query cannot be nil" if @query.nil?
      raise ArgumentError, "Query must be a string" unless @query.is_a?(String)
      raise ArgumentError, "Query contains invalid characters" if @query.match?(/[^a-zA-Z0-9\s,]/)
      raise ArgumentError, "Query is too long" if @query.length > 500
    end
  end
end
