class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.string :name, null:false
      t.string :email, null:false
      t.string :phone
      t.string :age
      t.string :gender
      t.string :source
      t.string :password_digest, null:false
      t.string :remember_token
      t.index :remember_token
      t.timestamps
    end
  end
end
