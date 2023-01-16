# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

NAME = 'Name'
PRICE = 'price'
UNIT = 'unit'
LABEL = 'item'
DATE = 'date'

CSV.foreach(("db/data/2022-12-06.csv"), headers: true, col_sep: ",") do |row|
  ProducePrice.create(label: row[LABEL].strip(),
                      date:  row[DATE],
                      unit:  row[UNIT],
                      price: row[PRICE])
end
