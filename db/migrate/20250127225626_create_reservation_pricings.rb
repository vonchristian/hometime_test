class CreateReservationPricings < ActiveRecord::Migration[8.0]
  def change
    create_table :reservation_pricings do |t|
      t.references :reser, null: false, foreign_key: true
      t.integer :payout_price_cents, null: false, default: 0
      t.integer :security_price_cents, null: false, default: 0
      t.integer :total_price_cents, null: false, default: 0
      t.string :currency, null: false
      t.timestamps
    end
  end
end
