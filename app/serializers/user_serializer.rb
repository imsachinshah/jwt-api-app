class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password, :username
end
