class Post < ApplicationRecord
  ActsAsTaggableOn.delimiter = " "
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 60000 }

  acts_as_taggable_on :tags
end
