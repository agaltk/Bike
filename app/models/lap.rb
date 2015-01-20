class Lap < ActiveRecord::Base
  belongs_to :activity
  has_many :tracks, :dependent => :destroy
  has_many :trackpoints, :through => :tracks
end
