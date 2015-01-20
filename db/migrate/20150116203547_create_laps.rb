class CreateLaps < ActiveRecord::Migration
  def change
    create_table :laps do |t|
      t.references :activity, index: true
      t.datetime :startTime
      t.float :totalTimeSeconds
      t.float :distanceMeters
      t.float :calories

      t.timestamps null: false
    end
    add_foreign_key :laps, :activities
  end
end
