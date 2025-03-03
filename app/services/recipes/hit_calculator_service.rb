module Recipes
  class HitCalculatorService
    def self.call(matched_count, total_count)
      return 0 if total_count.zero?

      (matched_count.to_f / total_count.to_f) * 100
    end
  end
end
