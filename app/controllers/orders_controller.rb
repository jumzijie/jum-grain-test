class OrdersController < ApplicationController
  def index
    orders = []
    DeliveryOrder.find_each do |delivery_order|
      orders.push(delivery_order.to_custom_json)
    end

    render json: {
      orders: orders,
    }, status: :ok
  end

  def show
    delivery_order = DeliveryOrder.find_by(order_id: params[:order_id])
    order = delivery_order.to_custom_json

    order[:order_items] = []
    delivery_order.order_items.each do |order_item|
      order[:order_items].push(order_item.to_custom_json)
    end

    render json: {
      order: order
    }, status: :ok
  end
end
