class Article < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  has_rich_text :body

  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :approved_by, class_name: "User", foreign_key: 'approved_by_id', optional: true
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :comments

  validates :title, presence: true
  # validates :body, presence: true
  validates :status, inclusion: { in: %w[draft under_review approved published] }

  enum :status, { draft: 0, under_review: 1, approved: 2, published: 3 }

  scope :published, -> { where(status: "published") }
  scope :approved, -> { where(status: "approved") }
  scope :under_review, -> { where(status: "under_review") }
  scope :draft, -> { where(status: "draft") }

  attr_accessor :tag_list
  after_save :assign_tags
  after_commit :schedule_publish_job, if: :should_schedule_publish_job?

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end

  # def self.tagged_with(name)
  #   Tag.find_by!(name: name).articles
  # end

  # def tag_list
  #   tags.map(&:name).join(", ")
  # end

  # def tag_list=(names)
  #   self.tags = names.split(",").map do |name|
  #     Tag.where(name: name.strip).first_or_create!
  #   end
  # end

  def assign_tags
    return unless tag_list

    tag_names = tag_list.split(',').map(&:strip).uniq
    self.tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
  end

  def image
    article_image = body.embeds.select { |embed| embed.image? }.first
  end

  def body_without_images
    doc = Nokogiri::HTML::DocumentFragment.parse(self.body.to_s)
    doc.css("figure, attachment").each(&:remove)
    doc.to_html.html_safe
  end

  def formatted_created_at
    "#{created_at.day.ordinalize} #{created_at.strftime('%b, %Y')}"
  end

  def formatted_updated_at
    "#{updated_at.day.ordinalize} #{updated_at.strftime('%b, %Y')}"
  end

  def should_schedule_publish_job?
    approved? && published_at.present? && published_at.future?
  end

  def schedule_publish_job
    PublishArticleJob.set(wait_until: published_at).perform_later(self)
  end
end
