class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def show
  end

  def search
    @recipes = Recipes::RecipeFinderService.new(params[:query]).call

    render "recipes/results"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
