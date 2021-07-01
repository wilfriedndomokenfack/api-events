class UserSerializer < ActiveModel::Serializer
  attributes :id, 
             :nome, 
             :cognome, 
             :email
             has_many :roles
end
