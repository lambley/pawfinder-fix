class Activity < ApplicationRecord
  # Constants for lookup - could be seperate tables
  CATEGORY = [
    "restaurant",
    "park",
    "dog bin"
  ]

  RESTAURANT_TYPE = [
    "italian",
    "indian",
    "chinese",
    "fast food",
    "cafe"
  ]

  PARK_FEATURES = [
    "pond",
    "dog play area",
    "playground",
    "water fountain"
  ]

  # associations
  belongs_to :user
  has_one :location
  has_many :reviews

  # validations
  validate :name, presence: true
  validate :description, length: { minimum: 6, maximum: 500 }
  validate :category, inclusion: CATEGORY
  validate :restaurant_type, inclusion: RESTAURANT_TYPE
  validate :park_feature, inclusion: PARK_FEATURE
end
