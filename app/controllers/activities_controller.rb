class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # find activities from search params
    if params[:category].present?
      # filter if park feature specified
      if params[:feature].present?
        # show all
        if params[:feature] == "all"

        end
        @activities = Activity.search_by_category(params[:category]).where(park_feature: params[:feature])
      # filter if restaurant_type specified
      elsif params[:restaurant_type].present?
        @activities = Activity.search_by_category(params[:category]).where(restaurant_type: params[:restaurant_type])
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
    @markers = @activities.map do |a|
      {
        lat: a.location.latitude,
        lng: a.location.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { activity: a })
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
