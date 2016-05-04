class Event < ActiveRecord::Base
  mount_uploader :cover_image, CoverImageUploader
  belongs_to :user
end
