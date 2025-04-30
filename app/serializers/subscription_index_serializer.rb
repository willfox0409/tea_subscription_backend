class SubscriptionIndexSerializer
  include JSONAPI::Serializer

  set_type :subscription
  
  attributes :title, :status, :frequency, :price
end