class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.datetime :date
      t.integer :duration
      t.float :average
      t.float :max
      t.float :distance

      t.timestamps
    end
  end
end
