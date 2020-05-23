# frozen_string_literal: true

require 'rails_helper'

describe Pub, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:city) }
end
