# == Schema Information
#
# Table name: produce_labels
#
#  id         :bigint           not null, primary key
#  label      :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ProduceLabel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
