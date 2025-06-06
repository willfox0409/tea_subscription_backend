class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.all
    subscriptions = subscriptions.with_status(params[:status]) if params[:status]

    render json: SubscriptionIndexSerializer.new(subscriptions).serializable_hash
  end

  def show
    subscription = Subscription.with_customer_and_tea.find(params[:id])

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
