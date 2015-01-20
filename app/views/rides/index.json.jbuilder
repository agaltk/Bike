json.array!(@rides) do |ride|
  json.extract! ride, :date, :duration, :average, :max, :distance
  json.url ride_url(ride, format: :json)
end
