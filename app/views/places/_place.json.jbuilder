json.extract! place, :id, :name, :latitude, :longitude, :initials, :address, :number, :neighborhood, :created_at, :updated_at
json.url place_url(place, format: :json)
