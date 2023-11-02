class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password, :username, :avatar

  attribute :avatar do |ob|
    if ob.avatar.present?
      ENV["LOCAL_HOST"] + Rails.application.routes.url_helpers.rails_blob_url(ob.avatar, only_path: true)
    else
      "Not Uploaded Profile Picture"
    end
  end
end
