class Ride < ActiveRecord::Base
	has_and_belongs_to_many :users

	def self.total_on(date)
    	where("date(date) = ?",date).sum(:distance)
  	end

    def self.all_by_date
      self.all
    end

end
