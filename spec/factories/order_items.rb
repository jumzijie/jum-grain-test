FactoryBot.define do
  factory :order_item do
    delivery_order nil
    serving_date "2018-01-23 14:44:37"
    meal nil
    quantity 1
    unit_price 1
  end
end
