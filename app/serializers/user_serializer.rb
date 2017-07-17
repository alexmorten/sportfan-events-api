class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:description,:lat,:lng,:website,:status
end
