namespace :import do
  desc 'Import recipes from json file'
  task recipes: :environment do
    file_path = Rails.root.join('db', 'recipes-en.json')

    begin
      Import::RecipeImporterService.new(file_path).call
      puts "Recipes successfully imported!"
    rescue Errno::ENOENT => e
      puts "Error: #{e.message}"
    rescue => e
      puts "Error: #{e.message}"
    end
  end
end
