# == Schema Information
#
# Table name: produce_prices
#
#  id         :bigint           not null, primary key
#  date       :date
#  label      :string
#  price      :decimal(, )
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProducePrice < ApplicationRecord
  def self.search(search)
    if search
      where("label LIKE :search ", search: "%#{search}%")
    end
  end
end
