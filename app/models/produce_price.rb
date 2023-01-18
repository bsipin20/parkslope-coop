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
    if search.blank?
      raise(ArgumentError.new("Search string cannot be blank"))
    else
      where("lower(label) LIKE :search ", search: "%#{search.downcase}%")
    end
  end
end