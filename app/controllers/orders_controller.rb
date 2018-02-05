class OrdersController < ApplicationController
  def home
    @orders = DeliveryOrder.all
  end

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
    if delivery_order
      order = delivery_order.to_custom_json

      order[:order_items] = []
      delivery_order.order_items.each do |order_item|
        order[:order_items].push(order_item.to_custom_json)
      end

      render json: {
        order: order
      }, status: :ok
    else
      render json: {
        error: "Cannot find DeliveryOrder with id '#{params[:order_id]}'"
      }, status: :error
    end
  end

  def feedbacks
    delivery_order = DeliveryOrder.find_by(order_id: params[:order_id])
    if delivery_order
      # create feedbacks for order_items
      params[:order_items].each do |feedback_params|
        # only create if order_item belongs to delivery_order, and feedback not created yet
        order_item = delivery_order.order_items.find_by(id: feedback_params[:id])
        if order_item && order_item.feedback.blank?
          feedback = Feedback.new(feedback_params.permit(:rating))
          feedback.ratable = order_item
          feedback.save
        end
      end

      # create feedback for delivery_order only if not yet created
      if delivery_order.feedback.blank?
        feedback = Feedback.new(params.permit(:rating, :comments))
        feedback.ratable = delivery_order
        feedback.save
      end

      redirect_to root_path, notice: "Thank you for your feedback!"
    else
      redirect_to root_path, alert: "Error: Can't find order."
    end
  end
end
