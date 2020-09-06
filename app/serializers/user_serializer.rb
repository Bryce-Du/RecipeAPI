class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :id, :users_ingredients
end
