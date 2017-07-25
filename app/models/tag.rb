class Tag < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy
  has_many :events, through: :links
end
