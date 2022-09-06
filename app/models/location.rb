class Location < ApplicationRecord
  # associations
  belongs_to :locatable, polymorphic: true

  # geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

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
