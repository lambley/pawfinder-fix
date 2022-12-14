class Location < ApplicationRecord
  # associations
  belongs_to :locatable, polymorphic: true

  # geocoder
  geocoded_by :address
  after_validation :geocode, unless: ->(obj) { obj.longitude.present? and obj.latitude.present? }

  # validations
  validates_presence_of :city
  validates_presence_of :postcode

  def address
    [street, city, postcode].compact.join(', ')
  end

  def coordinates
    [longitude, latitude].compact.join(', ')
  end
end
