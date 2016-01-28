class StoryLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :requestee, class_name: 'Story'
  belongs_to :requestor, class_name: 'Story'
end
