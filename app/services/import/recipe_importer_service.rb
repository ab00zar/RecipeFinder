module Import
  class RecipeImporterService
    def initialize(file_path)
      @file_path = file_path
    end

    def call
      validate_file_exists!

      begin
        recipes = parse_recipes_from_file

        recipes.each {|recipe_data| create_a_recipe(recipe_data) }

      rescue JSON::ParserError => e
        raise "Invalid JSON format: #{e.message}"
      rescue => e
        raise "Failed to import recipes: #{e.message}"
      end
    end

    private

    def validate_file_exists!
      raise FileNotFoundError, "File not found at #{@file_path}" unless File.exist?(@file_path)
    end

    def parse_recipes_from_file
      file_content = File.read(@file_path)
      JSON.parse(file_content)
    rescue JSON::ParserError => e
      raise "Error parsing JSON: #{e.message}"
    end

    def create_a_recipe(recipe_data)
      Recipe.find_or_create_by!(
        title: recipe_data["title"],
        cook_time: recipe_data["cook_time"],
        prep_time: recipe_data["prep_time"]
      ) do |recipe|
        recipe.assign_attributes(
          cook_time: recipe_data["cook_time"],
          prep_time: recipe_data["prep_time"],
          ratings: recipe_data["ratings"],
          category: recipe_data["category"],
          author: recipe_data["author"],
          image: recipe_data["image"],
          ingredients: recipe_data["ingredients"]
        )
      end
    end
  end
end
