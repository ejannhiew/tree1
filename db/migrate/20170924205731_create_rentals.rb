class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :rent_period
      t.integer :price
      t.integer :total

      t.timestamps
    end
  end
end
