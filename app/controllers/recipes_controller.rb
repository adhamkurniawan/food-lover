class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show, :search]
  layout 'app-user'

  def index
    @paginate = Recipe.page(1).per(12).order("created_at DESC")

    if params[:category].blank?
      @recipes = Recipe.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @recipes = Recipe.where(category_id: @category_id).order("created_at DESC")
      @paginate = Recipe.page(1).per(12).order("created_at DESC")
    end
	end

	def show
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to my_recipes_path, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to my_recipes_path
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

  def search
    if params[:search].present?
      @recipes = Recipe.search(params[:search])
    else
      @recipes = Recipe.all
    end
  end

  def upvote
    @recipe.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @recipe.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  def my_recipes
    @recipes = current_user.recipes
    @recipes = Recipe.page(1).per(12).order("created_at DESC")
  end

  private
  	def recipe_params
  		params.require(:recipe).permit(:title, :description, :image, :category_id, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  	end

    #def image_params
    #  params.require(:recipe).permit(:image)
    #end

  	def find_recipe
  		@recipe = Recipe.friendly.find(params[:id])
  	end
end
