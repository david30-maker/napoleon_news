class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @articles = Article.includes(:author).order(created_at: :desc)
    .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end
end
