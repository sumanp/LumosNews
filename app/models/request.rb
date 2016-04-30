class Request < ActiveRecord::Base
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
end
