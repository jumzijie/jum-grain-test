# == Schema Information
#
# Table name: delivery_orders
#
#  id               :integer          not null, primary key
#  order_id         :string
#  serving_datetime :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class DeliveryOrder < ApplicationRecord
  has_many :order_items
end
