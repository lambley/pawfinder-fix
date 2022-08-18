class Location < ApplicationRecord
  belongs_to :activity_id
  belongs_to :user_id
  belongs_to :post_id
end
