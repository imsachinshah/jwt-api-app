class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password, :username, :avatar

  attribute :avatar do |ob|
     ENV["LOCAL_HOST"] + Rails.application.routes.url_helpers.rails_blob_url(ob.avatar, only_path: true)
  end
end
