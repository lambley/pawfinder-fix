class AddLocatableToLocations < ActiveRecord::Migration[7.0]
  def change
    add_reference :locations, :locatable, polymorphic: true, null: false
  end
end
