class DogsController < ApplicationController
  def index
    # change this later to index only for current_user
    @dogs = Dog.all
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
