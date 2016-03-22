class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false
      t.boolean :email_confirmed, :default => false
      t.string :confirm_token
      t.string :phone
      t.string :age
      t.string :gender
      t.string :source
      t.string :practice_number
      t.string :status, :default => 'Not Applied'
      t.string :password_digest, null:false
      t.string :remember_token
      t.index :remember_token
      t.timestamps
    end
  end
end
