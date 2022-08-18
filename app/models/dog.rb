class Dog < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :breed, inclusion: @breeds
  validates :colour, inclusion: @colours
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :biography, length: { minimum: 10, maximum: 500 }
  @breeds = [
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
  @colours = [
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
end
