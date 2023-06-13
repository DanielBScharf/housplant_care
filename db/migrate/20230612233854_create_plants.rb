class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.references :house, null: false, foreign_key: true
      t.string :common_name
      t.string :other_name
      t.string :sunlight
      t.string :watering
      t.string :nickname
      t.string :location

      t.timestamps
    end
  end
end
