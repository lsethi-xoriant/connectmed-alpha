class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.date :date
      t.time :time
      t.integer :sessionId
      t.text :purpose_descrip
      t.text :duration
      t.text :medications
      t.text :allergies
      t.text :symptoms
      t.integer :doctor_id
      t.integer :patient_id
      t.timestamps
    end
  end
end
