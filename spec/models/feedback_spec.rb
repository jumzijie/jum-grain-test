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

require 'rails_helper'

RSpec.describe Feedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
