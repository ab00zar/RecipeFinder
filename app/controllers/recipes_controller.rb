class RecipesController < ApplicationController
  def show
  end

  def search

    @recipes = Recipes::RecipeFinderService.new(params[:query]).call

    render "recipes/results"
  end
end
