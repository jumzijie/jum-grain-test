# == Schema Information
#
# Table name: order_items
#
#  id                :integer          not null, primary key
#  delivery_order_id :integer
#  serving_date      :datetime
#  meal_id           :integer
#  quantity          :integer
#  unit_price        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_order_items_on_delivery_order_id  (delivery_order_id)
#  index_order_items_on_meal_id            (meal_id)
#
# Foreign Keys
#
#  fk_rails_...  (delivery_order_id => delivery_orders.id)
#  fk_rails_...  (meal_id => meals.id)
#

FactoryBot.define do
  factory :order_item do
    delivery_order nil
    serving_date "2018-01-23 14:44:37"
    meal nil
    quantity 1
    unit_price 1
  end
end
