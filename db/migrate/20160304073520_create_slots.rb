class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.date :date
      t.time :time
      t.integer :hour
      t.integer :minute
      t.boolean :is_open
      t.belongs_to :consult
      t.belongs_to :doctor
      t.timestamps
    end
  end
end
