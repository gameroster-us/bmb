class CreateGrounds < ActiveRecord::Migration[7.0]
  def change
    create_table :grounds do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
