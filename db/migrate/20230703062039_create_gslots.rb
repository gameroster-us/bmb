class CreateGslots < ActiveRecord::Migration[7.0]
  def change
    create_table :gslots do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.decimal :charge
      t.string :inprocess , default: nil
      t.references :ground, null: false, foreign_key: true

      t.timestamps
    end
  end
end
