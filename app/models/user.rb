class User < ApplicationRecord

	has_secure_password
	has_one_attached :avatar
	has_many :posts, dependent: :destroy
	has_many :notifications

	validates :name, presence: true
	validates :password, presence: true, on: :create
	validates :email, presence: true
	validates :username, presence: true, uniqueness: true
end
