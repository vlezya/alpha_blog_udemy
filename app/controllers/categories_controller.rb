class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category created successfuly'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category name updated successfuly'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      redirect_to categories_path, alert: 'You are not authorized to do so'
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
