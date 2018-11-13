require 'rails_helper'

RSpec.describe 'Pubs', type: :request do
  let!(:guest) do
    create(:user, email: 'guest@email.com', password: '12345678', role: 'guest')
  end
  let!(:pubs) { create_list(:pub, 10) }
  let(:pub_id) { pubs.first.id }

  # Test suite for GET /pubs (index)
  describe 'GET /pubs' do
    before do
      # Note `basic_credentials` is a custom helper to credentials request
      get '/pubs', headers: basic_credentials('guest@email.com', '12345678')
    end

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
    before do
      get "/pubs/#{pub_id}",
          headers: basic_credentials('guest@email.com', '12345678')
    end

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
    let!(:user) do
      create(:user, email: 'default@email.com', password: '12345678',
                    role: 'default')
    end
    # valid payload
    let(:valid_attributes) do
      {
        name: 'Delirium Cafe', country: 'Belgium', state: 'BE',
        city: 'Brussels', user_id: user.id
      }
    end

    context 'when the request is valid' do
      before do
        post '/pubs',
             params: valid_attributes,
             headers: basic_credentials('default@email.com', '12345678')
      end

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
      before do
        post '/pubs',
             params: { name: 'Foobar' },
             headers: basic_credentials('default@email.com', '12345678')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist, Country can't be blan/)
      end
    end

    context 'when the user is unauthorized' do
      before do
        post '/pubs',
             params: valid_attributes,
             headers: basic_credentials('guest@email.com', '00000000')
      end

      it 'returns status code 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  # Test suite for PUT /pubs/:id (update)
  describe 'PUT /pubs/:id' do
    let!(:owner) do
      create(:user, email: Faker::Internet.email, password: '12345678',
                    role: 'default')
    end
    let(:pub) { create(:pub, user: owner) }
    let(:new_pub_name) { Faker::LordOfTheRings.location }
    let(:valid_attributes) { { name: new_pub_name } }

    context 'when user is owner' do
      before do
        put "/pubs/#{pub.id}",
            params: valid_attributes,
            headers: basic_credentials(owner.email, owner.password)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        pub.reload
        expect(pub.name).to eq new_pub_name
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'when user is unauthorized' do
      let(:user) { create(:user, password: '12345678', role: 'default') }
      let(:pub) { create(:pub) }
      let(:request) do
        delete "/pubs/#{pub.id}",
               headers: basic_credentials(user.email, user.password)
      end

      it 'returns AccessDenied' do
        expect { request }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  # Test suite for DELETE /pubs/:id (destroy)
  describe 'DELETE /pubs/:id' do
    context 'when the user is admin' do
      let!(:admin) do
        create(:user, email: 'admin@email.com', password: '12345678',
                      role: 'admin')
      end

      before do
        delete "/pubs/#{pub_id}",
               headers: basic_credentials('admin@email.com', '12345678')
      end

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

    context 'when the user is owner' do
      let!(:owner) do
        create(:user, email: Faker::Internet.email, password: '12345678',
                      role: 'default')
      end
      let(:pub) { create(:pub, user: owner) }

      before do
        delete "/pubs/#{pub.id}",
               headers: basic_credentials(owner.email, owner.password)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
        expect { pub.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      context 'when the record does not exist' do
        let!(:user) { create(:user, password: '12345678', role: 'default') }

        before do
          delete '/pubs/5000',
                 headers: basic_credentials(user.email, user.password)
        end

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
end
