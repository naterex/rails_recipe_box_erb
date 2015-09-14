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
      redirect_to @recipe, success: 'Recipe was successfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @recipe.update(params_recipe)
      redirect_to @recipe, success: 'Recipe was successfully edited'
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, success: 'Recipe was successfully deleted'
  end

  private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def params_recipe
      params.require(:recipe).permit(:title, :description)
    end


end
