class Group < ApplicationRecord
  belongs_to :groupable, polymorphic: true
  belongs_to :user
  has_many :groups, as: :groupable, dependent: :destroy
  has_many :events


  def sub_group_ids
   deeper_ids = []
   groups.each{|group|
     deeper_ids += group.sub_group_ids()
   }
   p deeper_ids
   return deeper_ids.push(self.id)
  end

  def sub_events
    Event.where(:group_id => sub_group_ids)
  end
end
