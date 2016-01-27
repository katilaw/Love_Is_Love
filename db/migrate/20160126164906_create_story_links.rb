class CreateStoryLinks < ActiveRecord::Migration
  def change
    create_table :story_links do |t|
      t.references :requestee, index: true, null: false
      t.references :requestor, index: true, null: false
      t.string :accepted, default: false
    end
  end
end
