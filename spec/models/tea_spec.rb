require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to have_many(:customers).through(:subscriptions) }
  end
end
