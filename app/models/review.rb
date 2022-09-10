class Review < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :activity
  # validations
  validates :content, length: { minimum: 6 }
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
end
