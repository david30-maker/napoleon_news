class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @articles = Article.includes(:author).order(created_at: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json { render json: { articles: @articles, meta: { total_pages: @articles.total_pages, total_count: @articles.total_count } } }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user

    if @article.save
      respond_to do |format|
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render json: @article, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render json: @article, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content, status: :no_content }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :status, :published_at, :approved_at, :user_id)
  end
end

