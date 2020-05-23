# frozen_string_literal: true

require 'rails_helper'

describe 'Styles', type: :request do
  before do
    create(:user, email: 'guest@email.com', password: '12345678', role: 'guest')
  end

  let(:styles) { create_list(:style, 15) }
  let(:style_id) { styles.first.id }

  # Test suite for GET /styles (index)
  describe 'GET /styles' do
    # Note `basic_credentials` is a custom helper to credentials request
    before do
      create_list(:style, 15)
      get styles_path,
          headers: basic_credentials('guest@email.com', '12345678')
    end

    it 'returns styles' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it { expect(response).to have_http_status :ok }
  end

  # Test suite for GET /styles/:id (show)
  describe 'GET /styles/:id' do
    before do
      get style_path(style_id),
          headers: basic_credentials('guest@email.com', '12345678')
    end

    context 'when the record exists' do
      it 'returns the style' do
        expect(json).not_to be_empty
        expect(json[:id]).to eq style_id
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      let(:style_id) { 100 }

      it { expect(response).to have_http_status :not_found }
      it { expect(response.body).to match(/Couldn't find Style/) }
    end
  end

  # Test suite for POST /styles (create)
  describe 'POST /styles' do
    let(:user) do
      create(:user, email: 'user@email.com', password: '12345678',
                    role: 'default')
    end
    # valid payload
    let(:valid_attributes) do
      {
        name: 'German-Style Schwarzbier',
        school_brewery: 'German',
        user_id: user.id
      }
    end

    context 'when the request is valid' do
      before do
        post styles_path,
             params: valid_attributes,
             headers: basic_credentials(user.email, user.password)
      end

      it 'creates a style' do
        expect(json[:name]).to eq 'German-Style Schwarzbier'
        expect(json[:school_brewery]).to eq 'German'
      end

      it { expect(response).to have_http_status :created }
    end

    context 'when the request is invalid' do
      before do
        post styles_path,
             params: { name: 'Foobar' },
             headers: basic_credentials(user.email, user.password)
      end

      it { expect(response).to have_http_status :unprocessable_entity }

      it 'returns a validation failure message' do
        expect(response.body).
          to match(/Validation failed: User must exist, School brewery can't/)
      end
    end

    context 'when the user is unauthorized' do
      before do
        post styles_path,
             params: valid_attributes,
             headers: basic_credentials('other@email.com', '00000000')
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  # Test suite for PUT /styles/:id (update)
  describe 'PUT /styles/:id' do
    let(:owner) do
      create(:user, email: Faker::Internet.email, password: '12345678',
                    role: 'default')
    end
    let(:style) { create(:style, user: owner) }
    let(:new_style_name) { Faker::Beer.style }
    let(:valid_attributes) { { name: new_style_name } }

    context 'when the record exists' do
      before do
        put style_path(style.id),
            params: valid_attributes,
            headers: basic_credentials(owner.email, owner.password)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        style.reload
        expect(style.name).to eq new_style_name
      end

      it { expect(response).to have_http_status :no_content }
    end

    context 'when user is unauthorized' do
      let(:user) { create(:user, password: '12345678', role: 'default') }
      let(:style) { create(:style) }
      let(:request) do
        put style_path(style.id),
            params: valid_attributes,
            headers: basic_credentials(user.email, user.password)
      end

      it { expect { request }.to raise_error(CanCan::AccessDenied) }
    end
  end

  # Test suite for DELETE /styles/:id (destroy)
  describe 'DELETE /styles/:id' do
    context 'when the user is admin' do
      let(:admin) do
        create(:user, email: 'admin@email.com', password: '12345678',
                      role: 'admin')
      end

      before do
        delete style_path(style_id),
               headers: basic_credentials(admin.email, admin.password)
      end

      it { expect(response).to have_http_status :no_content }
    end

    context 'when the user is owner' do
      let(:owner) do
        create(:user, email: Faker::Internet.email, password: '12345678',
                      role: 'default')
      end
      let(:style) { create(:style, user: owner) }

      before do
        delete style_path(style.id),
               headers: basic_credentials(owner.email, owner.password)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
        expect { style.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the record does not exist' do
      let(:user) { create(:user, password: '12345678', role: 'default') }

      before do
        delete style_path(5000),
               headers: basic_credentials(user.email, user.password)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response.body).to match(/Couldn't find Style/) }
    end
  end
end
