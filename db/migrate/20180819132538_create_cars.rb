class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :model
      t.integer :battery_capacity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
