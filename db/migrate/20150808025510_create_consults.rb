class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.date :date
      t.time :time
      t.integer :doctor_id
      t.integer :patient_id
      t.timestamps
    end
  end
end
