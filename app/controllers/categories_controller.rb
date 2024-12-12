class CategoriesController < ApplicationController
  before_action :set_category, only: [:articles]

  def index
      @categories = Category.includes(:creator).order(created_at: :desc).page(params[:page]).per(10)

      respond_to do |format|
          format.html
          format.json { render json: @categories }
      end
  end

  def show

  end

      def articles
          @articles = @category.articles.includes(:author)
          respond_to do |format|
              format.html
              format.json { render json: @articles }
          end
      end

  private

  def set_category
      @category = Category.find(params[:id])
  end
end
