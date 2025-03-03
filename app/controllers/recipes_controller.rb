class RecipesController < ApplicationController
  def show
  end

  def search

    @recipes = Recipes::MatchingIngredientsService.new(params[:query]).call

    render "recipes/results"
  end
end
