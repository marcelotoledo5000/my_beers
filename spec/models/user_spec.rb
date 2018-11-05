require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:beers).dependent(:destroy) }
  it { should have_many(:styles).dependent(:destroy) }
  it { should have_many(:pubs).dependent(:destroy) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
