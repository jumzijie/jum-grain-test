require "rails_helper"

RSpec.describe "Orders", :type => :request do

  before do
    @delivery_order = DeliveryOrder.first_or_create(serving_datetime: Time.zone.now.beginning_of_day + 1.day + 11.hours)
  end

  it "get Orders" do
    get "/orders"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)

    parsed_response = JSON.parse(response.body)
    expect(parsed_response["orders"].is_a?(Array)).to eq(true)
    expect(parsed_response["orders"]).to include(@delivery_order.to_custom_json.stringify_keys)
  end

  it "get specific Order that exists" do
    get "/orders/#{@delivery_order.order_id}"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)
  end

  it "get specific Order that doesn't exist" do
    get "/orders/ABC123"
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:error)
  end
end
