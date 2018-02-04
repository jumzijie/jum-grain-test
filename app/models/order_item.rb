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

class OrderItem < ApplicationRecord
  # unit price is in cents
  has_one :feedback, as: :ratable
  belongs_to :delivery_order
  belongs_to :meal

  def to_custom_json
    {
      name: meal.name,
      quantity: quantity,
      total_price: unit_price * quantity
    }
  end
end
