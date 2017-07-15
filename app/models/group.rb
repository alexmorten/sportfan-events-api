class Group < ApplicationRecord
  belongs_to :groupable, polymorphic: true
  belongs_to :user
  has_many :groups, as: :groupable
  has_many :events
end
