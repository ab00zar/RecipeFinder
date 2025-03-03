module Recipes
  class HitCalculatorService
    def self.call(matched_count, total_count)
      total_count.zero? ? 0.0 : (matched_count.to_f / total_count.to_f) * 100
    end
  end
end
