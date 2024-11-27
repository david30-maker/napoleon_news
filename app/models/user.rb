class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :user_roles, dependent: :destroy
         has_many :role, through: :user_roles
         has_many :articles

         validates :first_name, :last_name, :email, presence: true
end
