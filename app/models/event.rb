class Event < ActiveRecord::Base
  mount_uploader :cover_image, CoverImageUploader
  validates :title, presence: true
  validates :description, length: { maximum: 140 }
  validates :url, presence: true
  validates :cover_image, presence: true

  belongs_to :user
end
