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

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
