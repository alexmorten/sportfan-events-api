class AddUserToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups,:user,index:true
  end
end
