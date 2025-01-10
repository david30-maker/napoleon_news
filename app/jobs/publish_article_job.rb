class PublishArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    return unless article.approved?

    article.update(status: :published)
  end
end
