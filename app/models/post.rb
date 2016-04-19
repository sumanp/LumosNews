class Post < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable_on :tags
  
  belongs_to :user
  validates :title, presence: true

end
