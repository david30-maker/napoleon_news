class AuthoredArticlesController < ApplicationController
  def index
    head :unauthorized unless current_user&.admin? || current_user.id == params[:author_id]
    head :unprocessable_entity if params[:author_id].blank?

    @author = User.find(params[:author_id])
    @articles = @author.authored_articles.order(created_at: :desc).page(params[:page]).per(50)
  end
end