class CreateStoryLinks < ActiveRecord::Migration
  def change
    create_table :story_links do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :requestor, index: true, null: false
      t.belongs_to :requestee, index: true, null: false
      t.string :requestee_title, null: false
      t.timestamps null: false
    end
  end
end
