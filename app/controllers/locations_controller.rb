class LocationsController < ApplicationController
  def index
    @locations = Location.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude
      }
    end
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_path, status: :see_other
    else
      redirect_to locations_new_path, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:location).permit(:street, :city, :postcode)
  end
end
