require 'rails_helper'

RSpec.describe Style, type: :model do
  it { should have_many(:beers).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:school_brewery) }
end
