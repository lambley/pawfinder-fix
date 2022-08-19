class Location < ApplicationRecord
  # associations
  belongs_to :activity
  belongs_to :user

  # validations
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :postcode
end
