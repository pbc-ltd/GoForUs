class Api::V1::OrdersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false, only: [:index, :create]

  # GET /api/v1/orders
  def index
    render json: user.orders
  end

  # POST /api/v1/orders
  def create
    @order = user.orders.new(order_params.except(:message))
    @order.customer = user
    @valid = @order.valid?
    if @valid
      @conversation = user.conversations.create!(partner: @order.partner, customer: user)
      @message = @conversation.messages.create!(body: order_params[:message], sender_id: user.id, customer_id: user.id)
      @order.conversation = @conversation
      if @order.save
        @saved = true
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(
      :partner_id, :pickup_location_lat, :pickup_location_lng,
      :dropoff_location_lat, :dropoff_location_lng, :estimated_cost,
      :final_cost, :message
    )
  end
end
