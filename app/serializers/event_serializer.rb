class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :lat, :lng, :date
  belongs_to :user
  belongs_to :group
end
