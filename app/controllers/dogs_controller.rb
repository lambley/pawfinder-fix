class DogsController < ApplicationController
  def index
    # find dogs from search params
    @dogs = params[:breed].present? ? Dog.search_by_breed(params[:breed]) : Dog.all
    # but default to all dogs if search leads to no results
    if @dogs.empty?
      @dogs = Dog.all
      flash[:notice] = "No dogs of selected breed found. Showing all dogs."
    end
    @markers = @dogs.map do |dog|
      {
        lat: dog.user.location.latitude,
        lng: dog.user.location.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { activity: dog })
      }
    end
    @usermarker = {
      lat: current_user.location.latitude,
      lng: current_user.location.longitude,
      info_window: render_to_string(partial: "shared/info_window", locals: {activity: current_user})
    }
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @dog = Dog.new()
    @user = current_user
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user = current_user
    if @dog.save
      redirect_to user_path(current_user), status: :see_other
    else
      redirect_to dog_new_path, status: :unprocessable_entity
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name,:breed, :colour, :age, :biography)
  end
end
