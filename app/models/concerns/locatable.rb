module Locatable
  extend ActiveSupport::Concern

  included do
    has_one :location, :as => :locatable
  end
end
