class PublishArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    return unless.approved? && article.published_at > Time.current

    article.update(status: :published)
  end
end
