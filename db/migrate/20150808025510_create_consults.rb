class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.text :sessionId
      t.text :purpose_descrip
      t.text :duration
      t.text :medications
      t.text :allergies
      t.text :symptoms
      t.text :internal_notes
      t.string :treatment_result
      t.text :treatment_descrip
      t.text :recording
      t.boolean :patient_waiting
      t.integer :doctor_id
      t.integer :patient_id
      t.integer :pharmacy_id
      t.timestamps
    end
  end
end
