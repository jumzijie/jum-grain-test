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

class OrderItem < ApplicationRecord
  # unit price is in cents
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
