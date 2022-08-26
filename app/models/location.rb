class Location < ApplicationRecord
  # associations
  belongs_to :locatable, polymorphic: true

  # validations
  validates_presence_of :city
  validates_presence_of :postcode

  # for geocoder gem
  geocoded_by :address
  after_validation :geocode

  def address
    [street, city, postcode].compact.join(', ')
  end
end
