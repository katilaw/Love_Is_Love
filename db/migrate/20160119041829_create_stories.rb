class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
