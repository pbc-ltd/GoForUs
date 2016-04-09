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
        @receipt = user.send_message(@order.partner, order_params[:message], 'Job Offer')
        @conversation = @receipt.conversation
        @order.mailboxer_conversation = @conversation

        if @order.save
          @saved = true
          Rails.logger.info @receipt.to_json
          Rails.logger.info @receipt.errors.to_json
          Rails.logger.info @conversation.to_json
          Rails.logger.info params
          Rails.logger.info @order.to_json
          Rails.logger.info @order.errors.to_json
          Rails.logger.info @order.conversation.to_json
        else
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
