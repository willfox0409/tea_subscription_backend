class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :price, :status, :frequency

  attribute :customer do |subscription|
    CustomerSerializer.new(subscription.customer).serializable_hash[:data]
  end

  attribute :tea do |subscription|
    TeaSerializer.new(subscription.tea).serializable_hash[:data]
  end
end