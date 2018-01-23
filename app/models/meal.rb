# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string
#  byline     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meal < ApplicationRecord
  has_many :order_items
end
