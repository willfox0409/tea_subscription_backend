require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:tea) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:frequency) }
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:tea_id) }
  end
end
