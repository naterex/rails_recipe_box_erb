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
      flash[:notice] = "Recipe was successfully created"
      redirect_to @recipe
    else
      flash.now[:error] = @recipe.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @recipe.update(params_recipe)
      flash[:notice] = "Recipe was successfully edited"
      redirect_to @recipe
    else
      flash.now[:error] = @recipe.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = "Recipe was successfully deleted"
    redirect_to root_path
  end

  private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def params_recipe
      params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :done, :_destroy], directions_attributes: [:id, :step, :done, :_destroy])
    end


end
