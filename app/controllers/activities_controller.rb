class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if user_signed_in? && params[:category].present?
      # locate activities near user
      locations = Location.near(current_user.location, params[:range]).where(locatable_type: "Activity")

      # convert list to active relation and search by category
      @activities = Activity.where(id: locations.map(&:locatable_id)).where(category: params[:category])
    else
      @activities = Activity.all
    end
    # filter by park feature
    if params[:park_feature].present?
      @activities = @activities.where(park_feature: params[:park_feature]) unless params[:park_feature] == "all"
    end

    # filter by restaurant type
    if params[:restaurant_type].present?
      @activities = @activities.where(restaurant_type: params[:restaurant_type]) unless params[:restaurant_type] == "all"
    end

    # default: if search results are empty
    if @activities.empty? || @activities.nil?
      @activities = Activity.all.search_by_category(params[:category])
      flash[:notice] = "No matches found - showing all #{params[:category].pluralize}"
    end

    # map markers
    @markers = mapbox_markers(@activities)
    @usermarker = {
      lat: current_user.location.latitude,
      lng: current_user.location.longitude,
      info_window: render_to_string(partial: "shared/info_window", locals: {activity: current_user})
    } unless !user_signed_in?
    if @usermarker.nil? || @usermarker.empty?
      @usermarker = {
        lat: 51.5,
        lng: 0
      }
    end
  end

  def new
    @activity = Activity.new()
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    street = params[:location][:street]
    city = params[:location][:city]
    postcode = params[:location][:postcode]
    if @activity.save!
      Location.create!(street:, city:, postcode:, locatable_id: @activity.id, locatable_type: "Activity")
      redirect_to activities_path, notice: "Created #{@activity.name.capitalize} sucessfully!"
    else
      flash[:alert] = "Failed to create activity"
      render :new
    end
  end

  private

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
    params.require(:activity).permit(:name, :description, :category, :restaurant_type, :park_feature, :cl_tag, :photo)
  end
end
