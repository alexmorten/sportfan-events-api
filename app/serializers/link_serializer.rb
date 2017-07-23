class LinkSerializer < ActiveModel::Serializer
  attributes :id
  has_one :event
  has_one :tag
end
