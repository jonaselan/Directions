require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'scope' do
    let!(:place) { create(:place, latitude: 11, longitude: 22, initials: 'XT') }
    let(:coordinates_array) { Place.all_lat_lng }
    let(:initials_array) { Place.all_initials }

    it "return array with every place's latitude and longitude" do
      expect(coordinates_array).to eq [[11, 22]]
    end
    it "return array with every place's initials" do
      expect(initials_array).to eq ['XT']
    end
  end
end
