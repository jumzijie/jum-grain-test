class OrdersController < ApplicationController
  def index
    render json: {
      request: "orders"
    }, status: :ok
  end

  def show
    render json: {
      request: "orders/#{params[:order_id]}"
    }, status: :ok
  end
end
