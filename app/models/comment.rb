class Comment < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :story
  validates :body, presence: true, null: false
end
