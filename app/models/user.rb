class User < ActiveRecord::Base
  enum status:[:normal,:verified,:admin]
  acts_as_mappable
  has_many :groups, as: :groupable, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :tags #dont use dependent: :destroy
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User


end
