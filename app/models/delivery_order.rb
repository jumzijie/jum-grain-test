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
  has_one :feedback, as: :ratable

  default_scope -> { order(created_at: :desc) }

  after_create :generate_order_id

  # eg. GO001
  def generate_order_id
    update_attributes(order_id: "GO" + id.to_s.rjust(3, '0'))
  end

  def to_custom_json
    {
      id: id,
      order_id: order_id,
      delivery_date: serving_datetime.strftime("%Y-%m-%d"),
      delivery_time: serving_datetime.strftime("%l:%M") + "-" + (serving_datetime + 30.minutes).strftime("%l:%M%p"),
      feedback_submitted: feedback.present?,
      order_items: order_items.map { |order_item| { order_item_id: order_item.id, name: order_item.meal.name } }
    }
  end

  # for handling feedback submission
  def to_feedback_json
    {
      order_id: order_id,
      delivery_date: serving_datetime.strftime("%B %-d"),
      delivery_time: serving_datetime.strftime("%l:%M%p"),
      order_items: order_items.map { |order_item| order_item.to_custom_json },
      feedback_submitted: feedback.present?
    }
  end
end
