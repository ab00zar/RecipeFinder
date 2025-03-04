class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def show
  end

  def search
    @recipes = Recipes::RecipeFinderService.new(params[:query]).call
    render "recipes/results"
  rescue ArgumentError => e
    flash[:error] = e.message
    redirect_to recipes_path
  rescue StandardError => e
    Rails.logger.error("Search error: #{e.message}")
    flash[:error] = "An unexpected error occurred during search"
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
