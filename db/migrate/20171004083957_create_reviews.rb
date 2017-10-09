class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, deafault: 1
      t.references :room, foreign_key: true
      t.references :rental, foreign_key: true
      t.references :tenant, foreign_key: true
      t.references :landowner, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
