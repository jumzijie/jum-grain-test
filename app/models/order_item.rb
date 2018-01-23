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
  belongs_to :delivery_order
  belongs_to :meal
end
