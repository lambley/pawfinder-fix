class Review < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :location
  # validations
  validate :content, presence: true, lenght: { minimum: 6 }
  validate :rating, numericality: { only_integer: true }
end
