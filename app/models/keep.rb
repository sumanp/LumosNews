class Keep < ActiveRecord::Base
  belongs_to :user
  belongs_to :kept, polymorphic: true
end
