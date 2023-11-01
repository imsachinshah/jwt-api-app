class CheckStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    posts = Post.where(status: false)

    posts.each do |post|
      post.update(status: true)
    end
  end
end
