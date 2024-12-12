class Article < ApplicationRecord
   has_rich_text :body

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories

  validates :title, presence: true
  # validates :body, presence: true
  validates :status, inclusion: { in: %w[draft under_review approved/scheduled published] }

  enum :status, { draft: 0, under_review: 1, "approved/scheduled": 2, published: 3 }

  scope :published, -> { where(status: "published") }
  scope :approved, -> { where(status: "approved/scheduled") }
  scope :under_review, -> { where(status: "under_review") }
  scope :draft, -> { where(status: "draft") }

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).articles
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
