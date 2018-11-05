require 'rails_helper'

RSpec.describe Pub, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:city) }
end
