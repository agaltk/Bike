module ChartsHelper


# 	 def distance_chart_series(rides, start_time)
#     	rides_by_day = rides.where(:date => start_time.beginning_of_day..Time.zone.now.end_of_day).
    			
#                     select("date,distance")
#     (start_time.to_date..Date.today).map do |date|
#       ride = rides_by_day.detect { |ride| ride.date.to_date == date }
#       ride && ride.distance.to_f || 0
#     end.inspect
# end

def data(what)

  @rides = Ride.all_by_date

  grouped_rides = []
 
  
  type = session[:type_of_chart] 
 
  if (type == "day") 
    rm = @rides.group_by{|r| r.date.at_beginning_of_day }
  elsif type == "week" 
    rm = @rides.group_by{|r| r.date.at_beginning_of_week}
  elsif type == "month" 
    rm = @rides.group_by{|r| r.date.beginning_of_month}
  elsif type == "year" 
   	rm = @rides.group_by{|r| r.date.at_beginning_of_year}
  end


  rm.each do |date, rides|
    distance_s = rides.sum(&:distance)/rides.size
    average_s = rides.sum(&:average)/rides.size
    max_s = rides.sum(&:max)/rides.size
    duration_s = rides.sum(&:duration)/rides.size

      if (type == "day" || type == nil) 
        grouped_rides <<["date" =>date.beginning_of_day, "distance" => distance_s, "average" => average_s, "max" => max_s, "duration" => duration_s ]
      elsif type == "week" 
        grouped_rides <<["date" =>date.beginning_of_week, "distance" => distance_s, "average" => average_s, "max" => max_s, "duration" => duration_s ]
      elsif type == "month" 
        grouped_rides <<["date" =>date.beginning_of_month, "distance" => distance_s, "average" => average_s, "max" => max_s, "duration" => duration_s ]
      elsif type == "year" 
        grouped_rides <<["date" =>date.beginning_of_year, "distance" => distance_s, "average" => average_s, "max" => max_s, "duration" => duration_s ]
      end
    
  end

  return grouped_rides.map{ |r| [r.first["date"].to_datetime.to_i*1000, r.first[what].to_f ] }.inspect	
 
end

def interval

  if (session[:type_of_chart] == "day") 
    return 1.day * 1000 
  elsif session[:type_of_chart] == "week" 
    return 1.week * 1000
  elsif session[:type_of_chart] == "month" 
    return 1.month * 1000
  elsif session[:type_of_chart]  == "year" 
    return 1.year * 1000
  end

  
end


end
