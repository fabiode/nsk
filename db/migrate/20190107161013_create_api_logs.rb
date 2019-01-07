class CreateApiLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :api_logs do |t|
      t.string :uuid, null: false
      t.text :request_data
      t.text :response

      t.timestamps
    end
    add_index :api_logs, :uuid, unique: true
  end
end
