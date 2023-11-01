class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password, :username, :avatar

  attribute :avatar do |ob|
     "http://127.0.0.1:3000/" + Rails.application.routes.url_helpers.rails_blob_url(ob.avatar, only_path: true)
  end
end
