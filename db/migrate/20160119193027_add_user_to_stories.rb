class AddUserToStories < ActiveRecord::Migration
  def change
    add_reference :stories, :creator, index: true, null: false
  end
end
