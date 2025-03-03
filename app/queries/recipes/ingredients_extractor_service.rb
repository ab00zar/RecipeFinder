module Recipes
  class IngredientsExtractorService
    def self.call(query)
      query.split(',').map(&:strip).reject(&:empty?)
    end
  end
end
