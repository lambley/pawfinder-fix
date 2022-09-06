class FavouritesController < ApplicationController
  def create
    activity = Activity.find(params[:activity_id])
    Favourite.create!(favouritable: activity, user_id: current_user.id)
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy

  end
end
