class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :keeps
  has_many :keep_posts, through: :keeps, source: :kept, source_type: 'Post'
  has_many :events
  has_many :keep_events, through: :keeps, source: :kept, source_type: 'Event'
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  acts_as_followable
  acts_as_follower



  def to_param
    "#{id} #{name}".parameterize
  end

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 3MB" if avatar.size > 3.megabytes
    end

end
