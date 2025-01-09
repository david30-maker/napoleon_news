class ManageArticlesController < ApplicationController
    before_action :authenticate_user!
    def index
        head :unauthorized unless current_user&.admin? || current_user&.editor?

        @articles_for_review = Article.under_review.page(params[:under_review_page]).per(10)
        @published_articles = Article.published.page(params[:published_page]).per(10)
    end
end