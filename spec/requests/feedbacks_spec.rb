require "rails_helper"

RSpec.describe "Feedbacks", :type => :request do

  before do
    # create 10 meals
    Meal.create(name: "A partridge in a pear tree", byline: "one")
    Meal.create(name: "Two turtle doves", byline: "two")
    Meal.create(name: "Three french hens", byline: "three")
    Meal.create(name: "Four calling birds", byline: "four")
    Meal.create(name: "Five golden rings", byline: "five")
    Meal.create(name: "Six geese a laying", byline: "six")
    Meal.create(name: "Seven swans a swimming", byline: "seven")
    Meal.create(name: "Eight maids a milking", byline: "eight")
    Meal.create(name: "Nine ladies dancing", byline: "nine")
    Meal.create(name: "Ten lords a leaping", byline: "ten")

    # create a delivery order that contains any number of order items ranging from 1 to 5
    serving_datetime = Time.zone.now.beginning_of_day + 11.hours # 11am
    delivery_order = DeliveryOrder.create(serving_datetime: serving_datetime)

    if delivery_order.order_items.blank?
      # create random number of order items ranging from 1 to 5
      num_order_items = rand(1..5)
      # keep track of selected meals, so don't repeat again
      selected_meal_ids = []
      num_order_items.times do |j|
        # random a meal that has not been selected yet
        meal = Meal.where.not(id: selected_meal_ids).sample
        selected_meal_ids.push(meal.id)

        order_item = OrderItem.new
        order_item.delivery_order = delivery_order
        order_item.meal = meal
        order_item.serving_date = delivery_order.serving_datetime
        order_item.quantity = [1,1,1,2].sample # random between 1 or 2, with a higher chance for 1
        order_item.unit_price = 800
        order_item.save
      end
    end

    @delivery_order = delivery_order
  end

  it "submitting of feedbacks" do
    feedbacks = []
    # not sure why, but @delivery_order.order_items doesn't work
    OrderItem.where(delivery_order_id: @delivery_order.id).each do |order_item|
      feedbacks.push({ ratable_id: order_item.id, ratable_type: OrderItem.to_s, rating: 1, comment: "Order item comment" })
    end
    feedbacks.push({ ratable_id: @delivery_order.id, ratable_type: DeliveryOrder.to_s, rating: 1, comment: "
      Delivery comment" })
    post "/orders/#{@delivery_order.order_id}/feedbacks", params: {
      feedbacks: feedbacks
    }
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)
  end

  describe "after submission of feedbacks" do
    before do
      OrderItem.where(delivery_order_id: @delivery_order.id).each do |order_item|
        feedback = Feedback.new(ratable_id: order_item.id, ratable_type: OrderItem.to_s, rating: 1, comment: "Order item comment")
        feedback.save!
      end

      feedback = Feedback.new(ratable_id: @delivery_order.id, ratable_type: DeliveryOrder.to_s, rating: 1, comment: "Delivery comment")
      feedback.ratable = @delivery_order
      feedback.save!
    end

    it "get existent feedbacks of specific order" do
      get "/orders/#{@delivery_order.order_id}/feedbacks"
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["feedbacks"].is_a?(Array)).to eq(true)
    end

    it "get inexistent feedbacks of specific order" do
      get "/orders/ABC123/feedbacks"
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:error)
    end
  end
end
