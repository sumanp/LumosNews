class Post < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  validates :title, presence: true

end
