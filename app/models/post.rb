class Post < ApplicationRecord
  belongs_to :author
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :content, allow_nil: true
  validates :publish_at, allow_nil: true
end
