class RemovePhoneFromGuests < ActiveRecord::Migration[8.0]
  def change
    remove_column :guests, :phone
  end
end
