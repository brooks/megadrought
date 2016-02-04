class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :percent
      t.date :date
      t.timestamps null: false
    end
  end
end
