class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :article

  enum :comment_type, [:review_comment, :reader_comment]
end
