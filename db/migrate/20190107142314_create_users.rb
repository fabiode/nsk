class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :document, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :name
      t.string :surname
      t.string :phone
      t.string :mobile_phone

      t.timestamps
    end
    add_index :users, :document, unique: true
    add_index :users, :email, unique: true
  end
end
