class ManageArticlesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def index
  end


  def draft
    # authorize_user!
    @draft_articles = Article.draft.order(updated_at: :desc).page(params[:draft_page]).per(12)
  end

  def under_review
    # authorize_user!
    @articles_for_review = Article.under_review.order(updated_at: :desc).page(params[:under_review_page]).per(12)
  end

  def published
    # authorize_user!
    @published_articles = Article.published.order(updated_at: :desc).page(params[:published_page]).per(12)
  end

  private

  def authorize_user!
    head :unauthorized unless current_user&.admin? || current_user&.editor?
  end
end