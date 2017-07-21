class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :title,      limit: 60,  null: false, unique: true
      t.string :filename,   limit: 40,  null: false
      t.integer :size,                  null: false, default: 0
      t.timestamps                      null:false
    end
  end
end
