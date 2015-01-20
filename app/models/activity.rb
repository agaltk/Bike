class Activity < ActiveRecord::Base
  require 'json'
	has_many :laps, :dependent => :destroy
	has_many :tracks, :through => :laps
    has_many :trackpoints, :through => :tracks
    has_attached_file :tcx

    do_not_validate_attachment_file_type :tcx
    before_save :parse_file


    def polyline
      points = self.laps.first.tracks.first.polyline_points.to_json
  
      #Polylines::Encoder.encode_points()
    end

    def distance
      distance = self.laps.first.distanceMeters
      distance = distance/1000
      return distance.to_s + "km"
    end

    def duration
     duration = self.laps.first.totalTimeSeconds
     duration = (duration/60).to_i
     minutes = duration % 60
     hours = (duration/60).to_i

     if hours>0 
      to_return = hours.to_s + "godz " + minutes.to_s + "min" 
     else 
      to_return = minutes.to_s + "min" 
    end
     to_return

    end

    def activity_id_to_js(id)
      content_tag(:script, :type => "text/javascript") do
        "var js_activity_id = "+id.to_s;
	  end
	end

    def parse_file
      tempfile = tcx.queued_for_write[:original]
      
      doc = Nokogiri::XML(tempfile)
      parse_xml(doc)
    end

    def parse_xml(doc)
      doc.root.elements.each do |node|
        parse_activities(node)
      end
    end


    def parse_activities(node)
  	  node.elements.each do |node|
        if node.node_name.eql? 'Activity'
      	      parse_activity(node)    
	    end
      end
    end

  def parse_activity(node)
	# TrainingCenterDatabase -> Activities -> Activity
	self.activityType = node.attr("Sport")
	node.elements.each do |node|
	  if node.node_name.eql? 'Lap'	
	    tmp_lap = Lap.new 
	    tmp_lap.startTime =  node.attr("StartTime")
	    node.elements.each do |node|
	      parse_laps(node,tmp_lap)
	    end
	    self.laps << tmp_lap
	  end
	end
  end



  def parse_laps(node,tmp_lap)
  	
  	  tmp_lap.totalTimeSeconds = node.text.to_s if node.name.eql? 'TotalTimeSeconds'
  	  tmp_lap.distanceMeters = node.text.to_s if node.name.eql? 'DistanceMeters'
  	  tmp_lap.calories = node.text.to_s if node.name.eql? 'Calories'
      if node.node_name.eql? 'Track'
        tmp_track = Track.new
        node.elements.each do |node|
          parse_tracks(node,tmp_track)
        end

        tmp_lap.tracks << tmp_track
        binding.pry
      end
    
  end


   def parse_tracks(node,tmp_track)
      if node.node_name.eql? 'Trackpoint'
        tmp_trackpoint = Trackpoint.new  
        node.elements.each do |node|
      	  tmp_trackpoint.time = node.text.to_s if node.name.eql? 'Time'
      	  tmp_trackpoint.altitudeMeters = node.text.to_s if node.name.eql? 'AltitudeMeters'
      	  if node.node_name.eql? 'Position'
      	    node.elements.each do |node|
      	  	  tmp_trackpoint.latitudeDegrees = node.text.to_s if node.name.eql? 'LatitudeDegrees'
      	  	  tmp_trackpoint.longitudeDegrees =  node.text.to_s if node.name.eql? 'LongitudeDegrees'
      	    end
      	  end
        end
   
        tmp_track.trackpoints << tmp_trackpoint
      end
  end

end
