class RecipesController < ApplicationController

  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def params_recipe
      params.require(:recipe).permit(:title, :description)
    end


end
