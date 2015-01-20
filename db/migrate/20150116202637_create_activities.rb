class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :activityType

      t.timestamps null: false
    end
    add_attachment :activities, :tcx
  end
end
