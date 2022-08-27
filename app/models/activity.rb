class Activity < ApplicationRecord
  # Constants for lookup - could be seperate tables
  CATEGORY = [
    "restaurant",
    "park",
    "dog bin"
  ]

  RESTAURANT_TYPE = [
    "barbecue",
    "british",
    "gastropub",
    "asian",
    "peruvian",
    "italian",
    "pizza",
    "american",
    "mediterranean",
    "european",
    "turkish",
    "mexican",
    "seafood",
    "jamaican",
    "deli",
    "sushi",
    nil
  ]

  PARK_FEATURE = [
    "football fields",
    "pond",
    "open fields",
    "playground",
    "dog park",
    "garden",
    nil
  ]

  # associations
  include Locatable
  belongs_to :user
  has_many :reviews

  # validations
  validates :name, presence: true
  validates :description, length: { minimum: 6, maximum: 500 }
  validates :category, inclusion: CATEGORY
  validates :restaurant_type, inclusion: RESTAURANT_TYPE
  validates :park_feature, inclusion: PARK_FEATURE

  # pg_search
  # include PgSearch::Model
  # pg_search_scope :search_by_location, against: :location

  def self.categories
    return CATEGORY.sort
  end

  def self.park_features
    return PARK_FEATURE.sort { |a,b| a <=> b || (b && 1) || -1 }
  end

  def self.locations
    locations = []
    Activity.all.each do |activity|
      locations << activity.location.address unless activity.location.nil?
    end
    return locations
  end

  def self.postcodes
    postcodes = []
    Activity.all.each do |activity|
      postcodes << activity.location.postcode unless activity.location.nil?
    end
    return postcodes
  end

  def average_rating
    round_to_one = reviews.map(&:rating).sum/reviews.map(&:rating).count.to_f
    round_to_one.round(1)
  end
end
