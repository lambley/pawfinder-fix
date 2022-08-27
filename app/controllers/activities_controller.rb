class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    # later - add search or where on category
    @markers = @activities.map do |activity|
      {
        lat: activity.location.latitude,
        lng: activity.location.longitude
      }
    end
  end

  def new
    @activity = Activity.new()
    @user = current_user
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    if @activity.save
      redirect_to activities_path, status: :see_other
    else
      redirect_to activities_new_path, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :category, :restaurant_type, :park_feature)
  end
end
