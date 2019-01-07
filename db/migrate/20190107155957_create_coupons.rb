class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :number, null: false
      t.integer :series, null: false
      t.string :uuid

      t.timestamps
    end
    add_index :coupons, :user_id
    add_index :coupons, :order_id
    add_index :coupons, :uuid, unique: true
  end
end
