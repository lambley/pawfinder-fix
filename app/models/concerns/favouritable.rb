module Favouritable
  extend ActiveSupport::Concern

  included do
    has_one :favourite, :as => :favouritable
  end
end
