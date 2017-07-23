class Tag < ApplicationRecord
  belongs_to :user
  has_many :links
  has_many :events, through: :links
end
