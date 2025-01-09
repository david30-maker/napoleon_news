class ReviewArticleController < ApplicationController
  before_action :authenticate_user!

  def show
    head :unauthorized unless current_user&.admin? || current_user&.editor
    debugger
    @article = Article.friendly.find(params[:slug])
    article_image = @article.image
    @article_image_url = article_image.present? ? url_for(article_image) : nil
    @article_body = @article_image_url.present? ? @article.body_without_images : @article.body
    @tag_classes = %w[bg-primary bg-secondary bg-success]
  end
end