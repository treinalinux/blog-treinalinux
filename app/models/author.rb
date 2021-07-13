class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :last_name, presence: true
  validates :description, allow_nil: true, length: { maximum: 500 }
end
