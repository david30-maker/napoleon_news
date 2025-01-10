class ArticleTag < ApplicationRecord
  # extend FriendlyId
  # friendly_id :slug_candidates, use: :slugged

  belongs_to :article
  belongs_to :tag

  private

  # def slug_candidates
  #   [
  #     :tag_name,
  #     [:tag_name, :article_title],
  #     [:tag_name, :article_title, :article_id]
  #   ]
  # end
end
