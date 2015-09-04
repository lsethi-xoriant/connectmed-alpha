class Pharmacies < ActiveRecord::Migration
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :country
      t.string :state
      t.string :city
      t.string :postalcode
      t.string :telephone
      t.string :email
      t.text :note
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
