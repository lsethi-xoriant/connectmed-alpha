class CreatePharmacies < ActiveRecord::Migration
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :place_id
      t.text :note
      t.timestamps
    end
  end
end
