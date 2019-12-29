# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

# If you are testing the Ability class through RSpec there is a be_able_to
# matcher available. This checks if the can? method returns true.
RSpec.describe Ability, type: :model do
  describe 'abilities' do
    subject(:ability) { described_class.new(user) }

    context 'when is an account manager' do
      let(:user) do
        create(:user, email: 'user@email.com', password: '12345678',
                      role: 'admin')
      end

      it { is_expected.to be_able_to(:manage, :all) }

      it { is_expected.to be_able_to(:manage, Pub) }
      it { is_expected.to be_able_to(:manage, Style) }
      it { is_expected.to be_able_to(:manage, Beer) }

      it { is_expected.to be_able_to(:create, Pub) }
      it { is_expected.to be_able_to(:create, Style) }
      it { is_expected.to be_able_to(:create, Beer) }
      it { is_expected.to be_able_to(:update, Pub) }
      it { is_expected.to be_able_to(:update, Style) }
      it { is_expected.to be_able_to(:update, Beer) }
      it { is_expected.to be_able_to(:destroy, Pub) }
      it { is_expected.to be_able_to(:destroy, Style) }
      it { is_expected.to be_able_to(:destroy, Beer) }
    end

    context 'when is an account default' do
      let(:user) do
        create(:user, email: 'default@email.com', password: '12345678',
                      role: 'default')
      end

      it { is_expected.to be_able_to(:read, :all) }
      it { is_expected.to be_able_to(:create, Pub) }
      it { is_expected.to be_able_to(:create, Style) }
      it { is_expected.to be_able_to(:create, Beer) }
      it { is_expected.to be_able_to(:update, Pub) }
      it { is_expected.to be_able_to(:update, Style) }
      it { is_expected.to be_able_to(:update, Beer) }
      it { is_expected.to be_able_to(:destroy, Pub) }
      it { is_expected.to be_able_to(:destroy, Style) }
      it { is_expected.to be_able_to(:destroy, Beer) }
    end

    context 'when is an account guest' do
      let(:user) do
        create(:user, email: 'guest@email.com', password: '12345678',
                      role: 'guest')
      end

      it { is_expected.to be_able_to(:read, :all) }
      it { is_expected.not_to be_able_to(:create, Pub) }
      it { is_expected.not_to be_able_to(:create, Style) }
      it { is_expected.not_to be_able_to(:create, Beer) }
      it { is_expected.not_to be_able_to(:update, Pub) }
      it { is_expected.not_to be_able_to(:update, Style) }
      it { is_expected.not_to be_able_to(:update, Beer) }
      it { is_expected.not_to be_able_to(:destroy, Pub) }
      it { is_expected.not_to be_able_to(:destroy, Style) }
      it { is_expected.not_to be_able_to(:destroy, Beer) }
    end
  end
end
