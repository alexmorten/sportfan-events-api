class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :lat, :lng, :date, :dist
  belongs_to :user
  belongs_to :group
  def dist
    lat = instance_options[:lat]
    lng = instance_options[:lng]
    if lat && lng && object.lat && object.lng
      return  object.distance_to(Event.new(lat: lat,lng: lng))
    else
      return nil
    end
  end
end
