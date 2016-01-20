class AddAssociationsToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :story, index: true, null: false
    add_reference :comments, :creator, index: true, null: false
  end
end
