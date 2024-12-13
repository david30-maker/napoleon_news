class Category < ApplicationRecord
    has_ancestry
    
    belongs_to :creator, class_name: "User", foreign_key: "created_by_id", optional: true
    has_many :article_categories, dependent: :destroy
    has_many :articles, through: :article_categories

    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
end
