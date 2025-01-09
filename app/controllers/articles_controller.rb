require 'nokogiri'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # def index
  #   @articles = Article.includes(:author).order(created_at: :desc).page(params[:page]).per(10)

  #   respond_to do |format|
  #     format.html
  #     format.json do
  #       render json: { 
  #         articles: @articles, 
  #         meta: { total_pages: @articles.total_pages, total_count: @articles.total_count }
  #       }
  #     end
  #   end
  # end

  def index
    @articles_under_review = Article.under_review.order(created_at: :desc).page(params[:page]).per(20)
    @published_articles = Article.published.order(created_at: :desc).page(params[:page]).per(20)
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
    modified_params = if params['commit'] == 'Publish Now'
      article_params.merge(published_at: Time.current, status: 'approved')
    elsif params['commit'] == 'Schedule'
      article_params.merge(status: 'approved')
    end

    debugger

    if @article.update(modified_params || article_params)
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
    @article.discard

    respond_to do |format|
      format.html { redirect_to request.referer || root_path, notice: "Article was deleted successfully." }
      format.json { head :no_content }
    end
  end

  def update_status
    status = params[:status]
    notice = case status
             when 'draft'
              'Article is now marked as draft!'
             when 'under_review'
              'Article has been submitted for review!'
             when 'approved'
              'Article has been approved for publishing!'
             when 'published'
              'Article has been published successfully'
             end

    if @article.update(status: status)
      redirect_to request.referer || root_path, notice: notice
    else
      redirect_to request.referer, alert: "Failed to update article status"
    end
  end

  private

  def set_article
    @article = Article.friendly.find(params[:slug])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to articles_url, alert: "Article not found." }
      format.json { render json: { error: "Article not found" }, status: :not_found }
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :description, :status, :published_at, :approved_at, :tag_list, category_ids: [])
  end
end
