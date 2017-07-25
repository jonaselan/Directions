class DirectionsController < ApplicationController

  def distance
    gon.places = Place.all_lat_lng
    gon.initials = Place.all_initials
  end

end
