class Post < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy 
  has_many_attached :post_images

  validates :title, presence: true
  validates :desc, presence: true

  after_create :create_notification

  private
    def create_notification
      Notification.create(heading: "New Post", content: "Post has been created", post_id: self.id, user_id: self.user.id)
    end
end
