class CreateProducePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :produce_prices do |t|
      t.string :label
      t.date :date
      t.string :unit
      t.decimal :price

      t.timestamps
    end
  end
end
