class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.string :name
      t.string :dosage
      t.text :notes
      t.string :result
      t.integer :consult_id
      t.timestamps
    end
    add_attachment :prescriptions, :image
  end
end
