class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :price, :status, :frequency

  attribute :customer do |subscription|
    CustomerSerializer.new(subscription.customer)
  end

  attribute :tea do |subscription|
    TeaSerializer.new(subscription.tea)
  end
end