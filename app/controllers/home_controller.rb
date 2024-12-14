class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @articles = Article.includes(:author).order(created_at: :desc)
    .page(params[:page]).per(10)

    @categories = {}
    Category.all.each { |category| @categories[category.name] = category_url(category) }
    @carousel_articles = Category.find_by(name: 'Carousel').articles.order(created_at: :desc).limit(4)

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end
end
