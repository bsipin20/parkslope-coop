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
class ProduceLabel < ApplicationRecord
end
