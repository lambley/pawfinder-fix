class FavouritesController < ApplicationController
  def create
    # check if activity is being favourited
    favouritable = Activity.find(params[:activity_id]) if params[:activity_id].present?
    # check if dog is being favourited
    favouritable = Dog.find(params[:dog_id]) if params[:dog_id].present?

    Favourite.create!(favouritable:, user_id: current_user.id)
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy

  end
end
