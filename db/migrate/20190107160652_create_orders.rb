class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :number, null: false

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :number, unique: true
  end
end
