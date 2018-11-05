require 'rails_helper'

RSpec.describe 'Pubs', type: :request do
  let!(:pubs) { create_list(:pub, 10) }
  let(:pub_id) { pubs.first.id }

  # Test suite for GET /pubs (index)
  describe 'GET /pubs' do
    before { get '/pubs' }

    it 'returns pubs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status :ok
    end
  end

  # Test suite for GET /pubs/:id (show)
  describe 'GET /pubs/:id' do
    before { get "/pubs/#{pub_id}" }

    context 'when the record exists' do
      it 'returns the pub' do
        expect(json).not_to be_empty
        expect(json['id']).to eq pub_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      let(:pub_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pub/)
      end
    end
  end

  # Test suite for POST /pubs (create)
  describe 'POST /pubs' do
    context 'when the request is valid' do
      # valid payload
      let(:valid_attributes) do
        {
          name: 'Delirium Cafe', country: 'Belgium', state: 'BE',
          city: 'Brussels'
        }
      end

      before { post '/pubs', params: valid_attributes }

      it 'creates a pub' do
        expect(json['name']).to eq 'Delirium Cafe'
        expect(json['country']).to eq 'Belgium'
        expect(json['state']).to eq 'BE'
        expect(json['city']).to eq 'Brussels'
      end

      it 'returns status code 201' do
        expect(response).to have_http_status :created
      end
    end

    context 'when the request is invalid' do
      before { post '/pubs', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Country can't be blank, State can't be/)
      end
    end
  end

  # Test suite for PUT /pubs/:id (update)
  describe 'PUT /pubs/:id' do
    let(:valid_attributes) { { name: Faker::Beer.name } }

    context 'when the record exists' do
      before { put "/pubs/#{pub_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end

  # Test suite for DELETE /pubs/:id (destroy)
  describe 'DELETE /pubs/:id' do
    before { delete "/pubs/#{pub_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status :no_content
    end

    context 'when the record does not exist' do
      let(:pub_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body)
          .to match(/Couldn't find Pub with/)
      end
    end
  end
end
