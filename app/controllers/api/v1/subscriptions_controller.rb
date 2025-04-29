class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.includes(:customer, :tea)
    render json: SubscriptionSerializer.new(subscriptions).serializable_hash, status: :ok
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription).serializable_hash, status: :ok
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update!(subscription_params)
    render json: SubscriptionSerializer.new(subscription).serializable_hash, status: :ok
  end

  private

  def subscription_params
    params.require(:subscription).permit(:status)
  end
end
