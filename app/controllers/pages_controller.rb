class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @activities = Activity.all
  end

  def profile
    @user = current_user
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
