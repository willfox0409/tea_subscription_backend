require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to have_many(:teas).through(:subscriptions) }
  end
end

