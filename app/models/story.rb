class Story < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  validates :title, presence: true, null: false
  before_validation :strip_whitespace
  validates :body, presence: true, null: false

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
