class AddFieldsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :phone_number, :string
    add_column :bookings, :user_information, :text
  end
end
