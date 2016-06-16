# app/models/topic.rb
class Tag < ActsAsTaggableOn::Tag
  acts_as_followable
end
