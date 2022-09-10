class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # find activities from search params
    if params[:category].present?
      # filter if park feature specified
      if params[:feature].present?
        @activities = park_search(params[:feature], params[:category])
      # filter if restaurant_type specified
      elsif params[:restaurant_type].present?
        @activities = restaurant_search(params[:restaurant_type], params[:category])
      # else bins
      else
        @activities = Activity.search_by_category(params[:category])
      end
    else
      @activities = Activity.all
    end
    # default to all Activities if search leads to no results
    if @activities.empty? || @activities.nil?
      @activities = Activity.all
      flash[:notice] = "No activities of selected category found. Showing all activities."
    end
    @markers = mapbox_markers(@activities)
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

  def park_search(park_feature, category)
    if park_feature == "all"
      activities = Activity.search_by_category(category)
    else
      activities = Activity.search_by_category(category).where(park_feature:)
    end

    return activities
  end

  def restaurant_search(restaurant_type, category)
    if restaurant_type == "all"
      activities = Activity.search_by_category(category)
    else
      activities = Activity.search_by_category(category).where(restaurant_type:)
    end

    return activities
  end

  def mapbox_markers(activities)
    markers = activities.map do |a|
      {
        lat: a.location.latitude,
        lng: a.location.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { activity: a })
      }
    end

    return markers
  end

  def activity_params
    params.require(:activity).permit(:name, :description, :category, :restaurant_type, :park_feature)
  end
end
