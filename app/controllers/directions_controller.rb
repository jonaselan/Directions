# DirectionsController: hold the logic of directions
class DirectionsController < ApplicationController

  def distances
    gon.places = Place.all_lat_lng
    gon.initials = Place.all_initials
  end

  def paths
    @places = Place.select(:latitude, :longitude, :initials)
  end

  def best_path
    @places = Place.select(:latitude, :longitude, :initials)
  end
end
