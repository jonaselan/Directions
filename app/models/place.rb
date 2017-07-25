class Place < ApplicationRecord
  validates :name, :initials, uniqueness: true
  validates :name, :initials, presence: true

  scope :all_lat_lng, -> { pluck(:latitude, :longitude) }
  scope :all_initials, -> { pluck(:initials) }
end
