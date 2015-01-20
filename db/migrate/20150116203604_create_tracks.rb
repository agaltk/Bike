class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :lap, index: true

      t.timestamps null: false
    end
    add_foreign_key :tracks, :laps
  end
end
