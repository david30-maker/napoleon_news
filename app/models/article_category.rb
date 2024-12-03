class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category

  validates :article_id, scope: :category_id, presence: true
end
