require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:tea) }
  end
end
