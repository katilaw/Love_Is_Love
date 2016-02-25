class Story < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  has_many :story_links
  validates :title, presence: true, null: false
  before_validation :strip_whitespace
  validates :body, presence: true, null: false
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :story_photo, StoryPhotoUploader

  def short_body
    desired_length = 40
    unless body.nil? || body.strip.empty?
      short_bod = ""
      body.split('').each_with_index.map do |char, index|
        short_bod << char if index < desired_length
      end
      short_bod + '...'
    end
  end

  def strip_whitespace
    title.strip unless title.nil?
  end
end
