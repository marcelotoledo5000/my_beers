# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Beer, type: :model do
  it { is_expected.to belong_to(:style) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:abv) }
  it { is_expected.to validate_presence_of(:ibu) }
  it { is_expected.to validate_presence_of(:nationality) }
  it { is_expected.to validate_presence_of(:brewery) }
  it { is_expected.to validate_presence_of(:description) }
end
