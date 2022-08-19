class Location < ApplicationRecord
  # associations
  belongs_to :locatable, polymorphic: true

  # validations
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :postcode
end
