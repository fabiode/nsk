class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :purpose
      t.string :response
      t.text :message

      t.timestamps
    end
    add_index :logs, :purpose
    add_index :logs, :response
  end
end
