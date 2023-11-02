class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :desc, :status, post_images: []

  # attribute :post_images do |obj|
  #   obj.post_images.each_with_object([]) do |image, array|
  #     array << "http://127.0.0.1:3000/" + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
  #   end
  # end

  attributes :post_images do |obj|
    data = []
    obj.post_images.each do |image|
      data << ENV["LOCAL_HOST"] + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    end
    data
  end
end
