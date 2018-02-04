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

FactoryBot.define do
  factory :meal do
    name "MyString"
    byline "MyString"
  end
end
