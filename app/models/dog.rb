class Dog < ApplicationRecord
  # Constants for column lookup - could be seperate model if needed
  BREEDS = [
    'Mix',
    'Labrador Retriever',
    'Golder Retriever',
    'German Shepherd',
    'Poodle',
    'Bulldog',
    'Beagle',
    'Rottweiler',
    'Dachshund',
    'Corgi',
    'Australian Shepherd',
    'Yorkshire Terrier',
    'Boxer',
    'Spaniel',
    'Great Dane',
    'Schnauzer',
    'Husky',
    'Bernese',
    'Shih Tzu',
    'Boston Terrier',
    'Pomeranian',
    'Border Collie',
    'Pug',
    'Basset Hound',
    'Mastiff',
    'Chihuahua',
    'Maltese',
    'Shiba Inu',
    'Newfoundland',
    'Bichons Frise',
    'Dalmatian',
    'Bloodhound',
    'Akita',
    'St. Bernard',
    'Samoyed',
    'Whippet',
    'Scottish Terrier'
  ]
  COLOURS = [
    'brown',
    'red',
    'black',
    'white',
    'gold',
    'yellow',
    'cream',
    'blue',
    'grey',
    'bicolour',
    'tricolour'
  ]

  # associations
  belongs_to :user
  has_one :location, through: :user

  # validations
  validates :name, presence: true
  validates :breed, inclusion: BREEDS
  validates :colour, inclusion: COLOURS
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :biography, length: { minimum: 10, maximum: 500 }
end
