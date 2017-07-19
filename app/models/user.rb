class User < ActiveRecord::Base
  enum status:[:normal,:verified,:admin]
  acts_as_mappable
  has_many :groups, as: :groupable
  has_many :events
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User


end
