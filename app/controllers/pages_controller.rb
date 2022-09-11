class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home restaurant park bin dog]

  def home
    @activities = Activity.all
  end

  def directions
    @usermarker = {
      lat: current_user.location.latitude,
      lng: current_user.location.longitude
    }
    activity = Activity.find(params[:activity_id])
    @destination = {
      lat: activity.location.latitude,
      lng: activity.location.longitude,
      info_window: render_to_string(partial: "shared/info_window", locals: { activity: })
    }
  end

  def profile
    @user = current_user
  end

  def private_profile
    @user = Dog.find(params[:dog_id]).user
  end

  def profile_reviews
    if params[:dog_id].present?
      @user = Dog.find(params[:dog_id]).user
    else
      @user = current_user
    end
    @reviews = @user.reviews
  end

  def restaurant
    respond_to do |format|
      format.text { render partial: "shared/restaurant_form", formats: [:html] }
    end
  end

  def park
    respond_to do |format|
      format.text { render partial: "shared/park_form", formats: [:html] }
    end
  end

  def bin
    respond_to do |format|
      format.text { render partial: "shared/bin_form", formats: [:html] }
    end
  end

  def dog
    respond_to do |format|
      format.text { render partial: "shared/dog_form", formats: [:html] }
    end
  end
end
