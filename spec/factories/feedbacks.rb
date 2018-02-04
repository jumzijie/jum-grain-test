# == Schema Information
#
# Table name: feedbacks
#
#  id           :integer          not null, primary key
#  ratable_type :string
#  ratable_id   :integer
#  rating       :integer
#  comment      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_feedbacks_on_ratable_type_and_ratable_id  (ratable_type,ratable_id)
#

FactoryBot.define do
  factory :feedback do
    ratable nil
  end
end
