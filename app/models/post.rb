class Post < ApplicationRecord
  belongs_to :author
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
end
