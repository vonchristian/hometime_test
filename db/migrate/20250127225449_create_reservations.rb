class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false, foreign_key: true
      t.string :start_date, null: false
      t.string :end_date, null: false
      t.integer :nights, null: false
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status

      t.timestamps
    end
  end
end
