class CreateTrackpoints < ActiveRecord::Migration
  def change
    create_table :trackpoints do |t|
      t.references :track, index: true
      t.float :latitudeDegrees
      t.float :longitudeDegrees
      t.float :altitudeMeters
      t.datetime :time

      t.timestamps null: false
    end
    add_foreign_key :trackpoints, :tracks
  end
end
