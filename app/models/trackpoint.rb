class Trackpoint < ActiveRecord::Base
  belongs_to :track

  def latlng
    {lat: self.latitudeDegrees, lng: self.longitudeDegrees}
  end
end
