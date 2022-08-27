class Location < ApplicationRecord
  # associations
  belongs_to :locatable, polymorphic: true

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
