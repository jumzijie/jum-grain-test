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
      if delivery_order.feedback.present?
        feedbacks = [delivery_order.feedback.to_custom_json]
        delivery_order.order_items.each do |order_item|
          feedbacks.push(order_item.feedback.to_custom_json)
        end

        render json: {
          feedbacks: feedbacks
        }, status: :ok
      else
        render json: {
          error: "DeliveryOrder #{params[:order_id]} has not received any feedback yet."
        }, status: :error
      end
    else
      render json: {
        error: "Cannot find DeliveryOrder with id '#{params[:order_id]}'"
      }, status: :error
    end
  end

  def submit_feedbacks
    delivery_order = DeliveryOrder.find_by(order_id: params[:order_id])
    if delivery_order
      if params[:feedbacks].present?
        # create feedbacks
        feedbacks = []
        params[:feedbacks].each do |feedback_params|
          feedback = Feedback.new(feedback_params.permit(:ratable_id, :ratable_type, :rating, :comment))
          feedback.save!
        end

        render json: {
          message: "Thank you for your feedback!"
        }, status: :ok
      else
        render json: {
          error: "Please fill in your feedback."
        }, status: :error
      end
    else
      render json: {
        error: "Cannot find DeliveryOrder with id '#{params[:order_id]}'"
      }, status: :error
    end
  end
end
