class Favourite < ApplicationRecord
  # associations
  belongs_to :favouritable, polymorphic: true
  belongs_to :user, inverse_of: :favourites

  validates :user_id, uniqueness: {
    scope: [:favouritable_id, :favouritable_type],
    message: 'can only favorite an item once'
  }

  scope :activities, -> { where(favoritable_type: 'Activity') }
  scope :dogs, -> { where(favoritable_type: 'Dog') }

end
