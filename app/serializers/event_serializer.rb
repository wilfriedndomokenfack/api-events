class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :from, :to, :user
end
