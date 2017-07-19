class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,:event_count,:direct_sub_group_count,:groupable_id,:groupable_type
  belongs_to :user

  def event_count
    object.sub_events.count
  end
  def direct_sub_group_count
    object.groups.count
  end
end
