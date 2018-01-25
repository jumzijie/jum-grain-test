require "rails_helper"

RSpec.describe "Orders", :type => :request do

  it "get Orders" do
    get "/orders"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)
  end

  it "get specific Order that exists" do
    @delivery_order = DeliveryOrder.create(serving_datetime: Time.zone.now.beginning_of_day + 1.day + 11.hours)
    get "/orders/#{@delivery_order.order_id}"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)
  end

  it "get specific Order that doesn't exist" do
    get "/orders/GO123"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:error)
  end
end
