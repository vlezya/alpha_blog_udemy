class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_some_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: t('flash.article.create.notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: t('flash.article.update.notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: t('flash.article.destroy.notice')
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_some_user
    unless current_user == @article.user
      flash[:alert] = 'You can to edit or delete your own article'
      redirect_to @article
    end
  end
end
