class DirectionsController < ApplicationController

  def distance
    @places = Place.pluck(:latitude, :longitude)
    @initials = Place.pluck(:initials)
  end

end
