require 'rails_helper'

RSpec.describe Beer, type: :model do
  it { should belong_to(:style) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:abv) }
  it { should validate_presence_of(:ibu) }
  it { should validate_presence_of(:nationality) }
  it { should validate_presence_of(:brewery) }
  it { should validate_presence_of(:description) }
end
