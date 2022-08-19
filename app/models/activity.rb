class Activity < ApplicationRecord
  belongs_to :user
  validate :name, presence: true
  validate :description, length: { minimum: 6, maximum: 500 }
  validate :category, inclusion: @category
  validate :restaurant_type, inclusion: @restaurant_types
  validate :park_feature, inclusion: @park_features

  @category = [
    "restaurant",
    "park",
    "dog bin"
  ]

  @restaurant_types = [
    "italian",
    "indian",
    "chinese",
    "fast food",
    "cafe"
  ]

  @park_features = [
    "pond",
    "dog play area",
    "playground",
    "water fountain"
  ]
end
