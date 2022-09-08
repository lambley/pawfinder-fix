class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # find activities from search params
    @activities = params[:category].present? ? Activity.search_by_category(params[:category]) : Activity.all
    # but default to all Activities if search leads to no results
    if @activities.empty?
      @activities = Activity.all
      flash[:notice] = "No activities of selected category found. Showing all dogs."
    end
    @activities = Activity.all
    @markers = @activities.map do |a|
      {
        lat: a.location.latitude,
        lng: a.location.longitude,
        info_window: render_to_string(partial: "info_window", locals: {activity: a})
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
    street = params[:location][:street]
    city = params[:location][:city]
    postcode = params[:location][:postcode]
    if @activity.save!
      Location.create!(street:, city:, postcode:, locatable_id: @activity.id, locatable_type: "Activity")
      flash.now[:notice] = "Created #{@activity.name.capitalize} sucessfully!"
      redirect_to activities_path, status: :see_other
    else
      flash.now[:alert] = "Failed to create activity"
      render :new
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :category, :restaurant_type, :park_feature)
  end
end
