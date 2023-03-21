class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category created successfuly'
    else
      render :new
    end
  end

  def show

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
