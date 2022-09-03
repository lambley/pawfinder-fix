class AddFavouritableToFavourites < ActiveRecord::Migration[7.0]
  def change
    add_reference :favourites, :favouritable, polymorphic: true, null: false
  end
end
