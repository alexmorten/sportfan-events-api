class Event < ApplicationRecord
  acts_as_mappable
  belongs_to :user
  belongs_to :group
end
