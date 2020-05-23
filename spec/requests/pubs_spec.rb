# frozen_string_literal: true

require 'rails_helper'

describe 'Pubs', type: :request do
  before do
    create(:user, email: 'guest@email.com', password: '123456', role: 'guest')
  end

  let(:pubs) { create_list(:pub, 15) }
  let(:pub_id) { pubs.first.id }

  # Test suite for GET /pubs (index)
  describe 'GET /pubs' do
    # Note `basic_credentials` is a custom helper to credentials request
    before do
      create_list(:pub, 15)
      get pubs_path, headers: basic_credentials('guest@email.com', '123456')
    end

    it 'returns pubs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it { expect(response).to have_http_status :ok }
  end

  # Test suite for GET /pubs/:id (show)
  describe 'GET /pubs/:id' do
    before do
      get pub_path(pub_id),
          headers: basic_credentials('guest@email.com', '123456')
    end

    context 'when the record exists' do
      it 'returns the pub' do
        expect(json).not_to be_empty
        expect(json[:id]).to eq pub_id
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      let(:pub_id) { 100 }

      it { expect(response).to have_http_status :not_found }
      it { expect(response.body).to match(/Couldn't find Pub/) }
    end
  end

  # Test suite for POST /pubs (create)
  describe 'POST /pubs' do
    let(:user) do
      create(:user, email: 'default@email.com', password: '123456',
                    role: 'default')
    end
    # valid payload
    let(:valid_attributes) do
      {
        name: 'Delirium Cafe',
        country: 'Belgium',
        state: 'BE',
        city: 'Brussels',
        user_id: user.id
      }
    end

    context 'when the request is valid' do
      before do
        post pubs_path,
             params: valid_attributes,
             headers: basic_credentials(user.email, user.password)
      end

      it 'creates a pub' do
        expect(json[:name]).to eq 'Delirium Cafe'
        expect(json[:country]).to eq 'Belgium'
        expect(json[:state]).to eq 'BE'
        expect(json[:city]).to eq 'Brussels'
      end

      it { expect(response).to have_http_status :created }
    end

    context 'when the request is invalid' do
      before do
        post pubs_path,
             params: { name: 'Foobar' },
             headers: basic_credentials(user.email, user.password)
      end

      it { expect(response).to have_http_status :unprocessable_entity }

      it 'returns a validation failure message' do
        expect(response.body).
          to match(/Validation failed: User must exist, Country can't be blan/)
      end
    end

    context 'when the user is unauthorized' do
      before do
        post pubs_path,
             params: valid_attributes,
             headers: basic_credentials('guest@email.com', '00000000')
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  # Test suite for PUT /pubs/:id (update)
  describe 'PUT /pubs/:id' do
    let(:owner) do
      create(:user, email: Faker::Internet.email, password: '123456',
                    role: 'default')
    end
    let(:pub) { create(:pub, user: owner) }
    let(:new_pub_name) { Faker::Movies::LordOfTheRings.location }
    let(:valid_attributes) { { name: new_pub_name } }

    context 'when user is owner' do
      before do
        put pub_path(pub.id),
            params: valid_attributes,
            headers: basic_credentials(owner.email, owner.password)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        pub.reload
        expect(pub.name).to eq new_pub_name
      end

      it { expect(response).to have_http_status :no_content }
    end

    context 'when user is unauthorized' do
      let(:user) { create(:user, password: '123456', role: 'default') }
      let(:pub) { create(:pub) }
      let(:request) do
        put pub_path(pub.id),
            headers: basic_credentials(user.email, user.password)
      end

      it { expect { request }.to raise_error(CanCan::AccessDenied) }
    end
  end

  # Test suite for DELETE /pubs/:id (destroy)
  describe 'DELETE /pubs/:id' do
    context 'when the user is admin' do
      let(:admin) do
        create(:user, email: 'admin@email.com', password: '123456',
                      role: 'admin')
      end

      before do
        delete pub_path(pub_id),
               headers: basic_credentials(admin.email, admin.password)
      end

      it { expect(response).to have_http_status :no_content }
    end

    context 'when the user is owner' do
      let(:owner) do
        create(:user, email: Faker::Internet.email, password: '123456',
                      role: 'default')
      end
      let(:pub) { create(:pub, user: owner) }

      before do
        delete pub_path(pub.id),
               headers: basic_credentials(owner.email, owner.password)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
        expect { pub.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the record does not exist' do
      let(:user) { create(:user, password: '123456', role: 'default') }

      before do
        delete pub_path(5000),
               headers: basic_credentials(user.email, user.password)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response.body).to match(/Couldn't find Pub with/) }
    end
  end
end
