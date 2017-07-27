class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def search
    if params[:search].present?
      @recipes = Recipe.search(params[:search])
    else
      @recipes = Recipe.all
    end
  end

  def index
    @recipes = Recipe.paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to root_path, notice: "Successfully created new recipe"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Successfully updated recipe"
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end

  def upvote
    @recipe.upvote_by current_user
    redirect_back fallback_location: root_path
  end

  def downvote
    @recipe.downvote_from current_user
    redirect_back fallback_location: root_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy],
      directions_attributes: [:id, :step, :_destroy])
    end

    def find_recipe
      @recipe = Recipe.friendly.find(params[:id])
    end
end
