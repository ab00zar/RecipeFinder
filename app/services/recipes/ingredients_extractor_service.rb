module Recipes
  class IngredientsExtractorService
    def self.call(query)
      query.split(',').map(&:strip).reject(&:empty?).map(&:singularize).uniq
    end
  end
end
