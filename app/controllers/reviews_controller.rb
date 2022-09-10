class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @activity = Activity.find(params[:activity_id])
    @reviews = Review.where(activity_id: @activity)
    @user = current_user if params[:user].present?
  end

  def new
    @review = Review.new
    @user = current_user
    # @activity = Activity.find(params[:activity_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.activity = Activity.find(params[:activity_id])
    if @review.save!
      flash[:notice] = "Review created successfully."
      redirect_to activities_path, status: :see_other
    else
      render :new
      flash[:alert] = "Something went wrong."
      # redirect_to activities_path, status: :unprocessable_entity

    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review.update(review_params)
    redirect_to activities_path, status: :ok
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
