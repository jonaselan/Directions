require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  let(:valid_attributes) {{
    name: 'sim',
    latitude: 0,
    longitude: 0,
    initials: 'ss',
    street: 'asd',
    number: 'asd',
    neighborhood: 'asd'
  }}
  let(:invalid_attributes) {{
    name: nil,
    initials: nil
  }}

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    let!(:place) { create(:place)}

    it 'returns a success response' do
      get :show, params: {id: place.id}
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    let!(:place) { create(:place)}
    it 'returns a success response' do
      get :edit, params: {id: place.id}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Place' do
        expect {
          post :create, params: {place: valid_attributes}
        }.to change(Place, :count).by(1)
      end

      it 'redirects to the created place' do
        post :create, params: {place: valid_attributes}
        expect(response).to redirect_to(Place.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the 'new' template)' do
        post :create, params: {place: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    let!(:place) { create(:place) }

    context 'with valid params' do
      it 'updates the requested place' do
        put :update, params: { id: place.id, place: { initials: 'TX' }}
        place.reload
        expect(place.initials).to eq 'TX'
      end

      it 'redirects to the place' do
        put :update, params: { id: place.id, place: {initials: 'TX'}}
        expect(response).to redirect_to(place)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the 'edit' template)' do
        put :update, params: {id: place.id, place: {name: nil}}
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:place) { create(:place)}

    it 'destroys the requested place' do
      expect {
        delete :destroy, params: {id: place.id}
      }.to change(Place, :count).by(-1)
    end

    it 'redirects to the places list' do
      delete :destroy, params: {id: place.id}
      expect(response).to redirect_to(places_url)
    end
  end

end
