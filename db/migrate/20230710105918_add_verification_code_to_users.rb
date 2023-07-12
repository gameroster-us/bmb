class AddVerificationCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :checkotp, :string
  end
end
