class Api::V1::OrdersController < Api::V1::BaseController
  # GET /api/v1/orders
  def index
    render json: user.orders
  end

  # POST /api/v1/orders
  def create
    @order = user.orders.new(order_params)
    @order.mailboxer_conversation = user.send_message(order.partner, order_params[:message], 'Job Offer').conversation
    if @order.save
      render json: @order.to_json
    else
      render json: {
        error: { order: 'Unable to create Order' }
      }
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
