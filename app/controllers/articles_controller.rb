require 'nokogiri'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @articles = Article.includes(:author).order(created_at: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json do
        render json: { 
          articles: @articles, 
          meta: { total_pages: @articles.total_pages, total_count: @articles.total_count }
        }
      end
    end
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html { render :new, status: :ok }
    end
  end

  def edit
    respond_to do |format|
      format.html { render :edit, status: :ok }
    end
  end

  def show
    article_image = @article.image
    @article_image_url = article_image.present? ? url_for(article_image) : nil
    @article_body = @article_image_url.present? ? @article.body_without_images : @article.body
    @tag_classes = %w[bg-primary bg-secondary bg-success]

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  def create
    @article = current_user.authored_articles.build(article_params)

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
      format.json { head :no_content }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to articles_url, alert: "Article not found." }
      format.json { render json: { error: "Article not found" }, status: :not_found }
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :status, :published_at, :approved_at, :tag_list)
  end

  # def body_without_images(article)
  #   # document = Nokogiri::HTML(article.body.to_s)
  #   # document.search('img').remove
  #   # document.to_html.html_safe

  #   doc = Nokogiri::HTML::DocumentFragment.parse(article.body.to_s)
  #   doc.css("figure, attachment").each(&:remove)
  #   doc.to_html.html_safe
  # end
end
