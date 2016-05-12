class Post < ActiveRecord::Base
  serialize :embedable, Hash

  acts_as_commentable
  acts_as_votable
  acts_as_taggable_on :tags

  belongs_to :user
  validates :title, presence: { message: ": Every story has a title :)" }
  validates :url, :format => URI::regexp(%w(http https))

end
