class AddReferencesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :user,index: true
    add_reference :events, :group,index: true
  end
end
