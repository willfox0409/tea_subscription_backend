require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to have_many(:customers).through(:subscriptions) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:temperature) }
    it { is_expected.to validate_presence_of(:brew_time) }
  end
end
