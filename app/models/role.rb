class Role < ApplicationRecord

    has_many :user_roles, dependent: :destroy
    has_many :users, through: :user_roles

    validates :title, presence: true
end
