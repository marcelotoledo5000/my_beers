require 'rails_helper'

RSpec.describe 'Beers', type: :request do
  let!(:guest) do
    create(:user, email: 'guest@email.com', password: '12345678', role: 'guest')
  end
  let!(:beers) { create_list(:beer, 10) }
  let(:beer_id) { beers.first.id }

  # Test suite for GET /beers (index)
  describe 'GET /beers' do
    # Note `basic_credentials` is a custom helper to credentials request
    before do
      get '/beers', headers: basic_credentials('guest@email.com', '12345678')
    end

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
    before do
      get "/beers/#{beer_id}",
          headers: basic_credentials('guest@email.com', '12345678')
    end

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
    let(:msg) do
      'What we’ve got here is an imperial stout brewed with a massive amount
      of coffee and chocolates, then cave-aged in oak bourbon barrels for an
      entire year to make sure wonderful bourbon undertones come through in
      the finish.'
    end
    let!(:user) do
      create(:user, email: 'user@email.com', password: '12345678',
                    role: 'default')
    end
    let!(:style) do
      create(:style,
             name: 'American-Style Imperial Stout',
             school_brewery: 'American', user_id: user.id)
    end
    # valid payload
    let(:valid_attributes) do
      {
        name: 'KBS',
        style_id: style.id,
        user_id: user.id,
        abv: '11.9%',
        ibu: '70',
        nationality: 'American',
        brewery: 'Founders',
        description: msg
      }
    end

    context 'when the request is valid' do
      before do
        post '/beers', params: valid_attributes,
                       headers: basic_credentials('user@email.com', '12345678')
      end

      it 'creates a beer' do
        expect(json['name']).to eq 'KBS'
        expect(json['abv']).to eq '11.9%'
        expect(json['ibu']).to eq '70'
        expect(json['nationality']).to eq 'American'
        expect(json['brewery']).to eq 'Founders'
        expect(json['description']).to eq msg
      end

      it 'returns status code 201' do
        expect(response).to have_http_status :created
      end
    end

    context 'when the request is invalid' do
      before do
        post '/beers',
             params: { name: 'Foobar' },
             headers: basic_credentials('user@email.com', '12345678')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a validation failure message' do
        expect(response.body).
          to match(/Validation failed: Style must exist, User must exist/)
      end
    end

    context 'when the user is unauthorized' do
      before do
        post '/beers',
             params: valid_attributes,
             headers: basic_credentials('user@email.com', '00000000')
      end

      it 'returns status code 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  # Test suite for PUT /beers/:id (update)
  describe 'PUT /beers/:id' do
    let!(:owner) do
      create(:user, email: Faker::Internet.email, password: '12345678',
                    role: 'default')
    end
    let(:beer) { create(:beer, user: owner) }
    let(:new_beer_name) { Faker::Beer.name }
    let(:valid_attributes) { { name: new_beer_name } }

    context 'when the record exists' do
      before do
        put "/beers/#{beer.id}",
            params: valid_attributes,
            headers: basic_credentials(owner.email, owner.password)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        beer.reload
        expect(beer.name).to eq new_beer_name
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'when user is unauthorized' do
      let(:user) { create(:user, password: '12345678', role: 'default') }
      let(:beer) { create(:beer) }
      let(:request) do
        delete "/beers/#{beer.id}",
               headers: basic_credentials(user.email, user.password)
      end

      it 'returns AccessDenied' do
        expect { request }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  # Test suite for DELETE /beers/:id (destroy)
  describe 'DELETE /beers/:id' do
    context 'when the user is admin' do
      let!(:admin) do
        create(:user, email: 'admin@email.com', password: '12345678',
                      role: 'admin')
      end

      before do
        delete "/beers/#{beer_id}",
               headers: basic_credentials('admin@email.com', '12345678')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end

      context 'when the record does not exist' do
        let(:beer_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status :not_found
        end

        it 'returns a not found message' do
          expect(response.body).
            to match(/Couldn't find Beer with/)
        end
      end
    end

    context 'when the user is owner' do
      let!(:owner) do
        create(:user, email: Faker::Internet.email, password: '12345678',
                      role: 'default')
      end
      let(:beer) { create(:beer, user: owner) }

      before do
        delete "/beers/#{beer.id}",
               headers: basic_credentials(owner.email, owner.password)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
        expect { beer.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the record does not exist' do
      let!(:user) { create(:user, password: '12345678', role: 'default') }

      before do
        delete '/beers/5000',
               headers: basic_credentials(user.email, user.password)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).
          to match(/Couldn't find Beer with/)
      end
    end
  end
end
