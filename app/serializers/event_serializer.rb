class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :lat, :lng, :date
end
