class CreateProduceLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :produce_labels do |t|
      t.string :label
      t.string :unit

      t.timestamps
    end
  end
end
