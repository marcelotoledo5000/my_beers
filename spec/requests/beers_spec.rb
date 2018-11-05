require 'rails_helper'

RSpec.describe 'Beers', type: :request do
  let!(:beers) { create_list(:beer, 10) }
  let(:beer_id) { beers.first.id }

  # Test suite for GET /beers (index)
  describe 'GET /beers' do
    before { get '/beers' }

    it 'returns beers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status :ok
    end
  end

  # Test suite for GET /beers/:id (show)
  describe 'GET /beers/:id' do
    before { get "/beers/#{beer_id}" }

    context 'when the record exists' do
      it 'returns the beer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq beer_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      let(:beer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Beer/)
      end
    end
  end

  # Test suite for POST /beers (create)
  describe 'POST /beers' do
    context 'when the request is valid' do
      let!(:style) do
        create(:style, name: 'American-Style Imperial Stout',
                       school_brewery: 'American')
      end
      # valid payload
      let(:valid_attributes) do
        {
          name: 'KBS',
          style_id: style.id,
          abv: '11.9%',
          ibu: '70',
          nationality: 'American',
          brewery: 'Founders',
          description: 'What we’ve got here is an imperial stout brewed with a massive amount of coffee and chocolates, then cave-aged in oak bourbon barrels for an entire year to make sure wonderful bourbon undertones come through in the finish.'
        }
      end

      before { post '/beers', params: valid_attributes }

      it 'creates a beer' do
        expect(json['name']).to eq 'KBS'
        expect(json['abv']).to eq '11.9%'
        expect(json['ibu']).to eq '70'
        expect(json['nationality']).to eq 'American'
        expect(json['brewery']).to eq 'Founders'
        expect(json['description']).to eq 'What we’ve got here is an imperial stout brewed with a massive amount of coffee and chocolates, then cave-aged in oak bourbon barrels for an entire year to make sure wonderful bourbon undertones come through in the finish.'
      end

      it 'returns status code 201' do
        expect(response).to have_http_status :created
      end
    end

    context 'when the request is invalid' do
      before { post '/beers', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Style must exist, Abv can't be blank/)
      end
    end
  end

  # Test suite for PUT /beers/:id (update)
  describe 'PUT /beers/:id' do
    let(:valid_attributes) { { name: Faker::Beer.name } }

    context 'when the record exists' do
      before { put "/beers/#{beer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end

  # Test suite for DELETE /beers/:id (destroy)
  describe 'DELETE /beers/:id' do
    before { delete "/beers/#{beer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status :no_content
    end

    context 'when the record does not exist' do
      let(:beer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body)
          .to match(/Couldn't find Beer with/)
      end
    end
  end
end
