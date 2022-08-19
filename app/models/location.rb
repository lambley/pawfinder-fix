class Location < ApplicationRecord
  # associations
  belongs_to :activity
  belongs_to :user

  # validations
  validate_presence_of :street
  validate_presence_of :city
  validate_presence_of :postcode
end
