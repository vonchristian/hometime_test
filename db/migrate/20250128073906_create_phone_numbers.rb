class CreatePhoneNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :phone_numbers do |t|
      t.belongs_to :guest, null: false, foreign_key: true
      t.string :number
      t.string :phone_type, null: false, default: 'primary'

      t.timestamps
    end
  end
end
