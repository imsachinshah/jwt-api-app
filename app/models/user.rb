class User < ApplicationRecord

	has_secure_password
	has_many :posts, dependent: :destroy

	validates :name, presence: true
	validates :password, presence: true
	validates :email, presence: true
	validates :username, presence: true, uniqueness: true
end