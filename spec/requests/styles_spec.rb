require 'rails_helper'

RSpec.describe 'Styles', type: :request do
  let!(:styles) { create_list(:style, 10) }
  let(:style_id) { styles.first.id }

  # Test suite for GET /styles (index)
  describe 'GET /styles' do
    before { get '/styles' }

    it 'returns styles' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status :ok
    end
  end

  # Test suite for GET /styles/:id (show)
  describe 'GET /styles/:id' do
    before { get "/styles/#{style_id}" }

    context 'when the record exists' do
      it 'returns the style' do
        expect(json).not_to be_empty
        expect(json['id']).to eq style_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      let(:style_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Style/
      end
    end
  end

  # Test suite for POST /styles (create)
  describe 'POST /styles' do
    # valid payload
    let(:valid_attributes) do
      { name: 'German-Style Schwarzbier', school_brewery: 'German' }
    end

    context 'when the request is valid' do
      before { post '/styles', params: valid_attributes }

      it 'creates a style' do
        expect(json['name']).to eq 'German-Style Schwarzbier'
        expect(json['school_brewery']).to eq 'German'
      end

      it 'returns status code 201' do
        expect(response).to have_http_status :created
      end
    end

    context 'when the request is invalid' do
      before { post '/styles', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: School brewery can't be blank/)
      end
    end
  end

  # Test suite for PUT /styles/:id (update)
  describe 'PUT /styles/:id' do
    let(:valid_attributes) { { name: Faker::Beer.style } }

    context 'when the record exists' do
      before { put "/styles/#{style_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end

  # Test suite for DELETE /styles/:id (destroy)
  describe 'DELETE /styles/:id' do
    before { delete "/styles/#{style_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status :no_content
    end

    context 'when the record does not exist' do
      let(:style_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Style/
      end
    end
  end
end
