class Track < ActiveRecord::Base
  belongs_to :lap
  has_many :trackpoints, :dependent => :destroy

  def polyline_points
	self.trackpoints.map(&:latlng)
  end

  
end