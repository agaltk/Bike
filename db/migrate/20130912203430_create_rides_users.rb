class CreateRidesUsers < ActiveRecord::Migration
  def self.up
    create_table :rides_users do |t|
    	t.integer :ride_id
    	t.integer :user_id
    end
  end

  def self.down
  	 drop_table :rides_users
  end
end
