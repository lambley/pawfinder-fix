class Review < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :location
  # validations
  validates :content, presence: true, lenght: { minimum: 6 }
  validates :rating, numericality: { only_integer: true }
end
