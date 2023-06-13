class AddScientificNameToPlants < ActiveRecord::Migration[7.0]
  def change
   add_column :plants, :scientific_name, :string
  end
end
