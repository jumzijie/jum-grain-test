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

FactoryBot.define do
  factory :delivery_order do
    order_id "MyString"
    serving_datetime "2018-01-23 14:37:54"
  end
end
