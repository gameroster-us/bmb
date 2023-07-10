class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :order_id
      t.decimal :total_payment
      t.references :user, null: false, foreign_key: true
      t.references :gslot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
