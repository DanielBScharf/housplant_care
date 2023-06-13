class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :plant_schedule
      t.timestamps
    end
  end
end
