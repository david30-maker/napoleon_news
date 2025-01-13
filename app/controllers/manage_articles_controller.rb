class ManageArticlesController < ApplicationController
    before_action :authenticate_user!
    def index
        head :unauthorized unless current_user&.admin? || current_user&.editor?

        @articles_for_review = Article.under_review.order(updated_at: :desc).page(params[:under_review_page]).per(10)
        @published_articles = Article.published.order(updated_at: :desc).page(params[:published_page]).per(10)
    end
end