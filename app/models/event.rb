class Event < ApplicationRecord
  acts_as_mappable
  belongs_to :user
  belongs_to :group
  has_many :links
  has_many :tags, through: :links
end
