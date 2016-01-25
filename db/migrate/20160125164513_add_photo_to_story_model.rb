class AddPhotoToStoryModel < ActiveRecord::Migration
  def change
    add_column :stories, :story_photo, :string
  end
end
