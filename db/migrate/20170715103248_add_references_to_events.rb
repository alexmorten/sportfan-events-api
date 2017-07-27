class AddReferencesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :user,index: true, type: :uuid
    add_reference :events, :group,index: true, type: :uuid
  end
end
