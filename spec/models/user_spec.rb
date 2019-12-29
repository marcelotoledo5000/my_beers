# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:beers).dependent(:destroy) }
  it { is_expected.to have_many(:styles).dependent(:destroy) }
  it { is_expected.to have_many(:pubs).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_secure_password }
  it { is_expected.to define_enum_for(:role) }
end
