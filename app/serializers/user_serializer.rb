class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:description,:lat,:lng,:website,:status,:event_count

  def event_count
    object.events.count
  end
end
