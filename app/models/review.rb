class Review < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validate :content, presence: true, lenght: { minimum: 6 }
  validate :rating, numericality: { only_integer: true }
end
