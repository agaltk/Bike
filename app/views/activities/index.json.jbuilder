json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :activityType
  json.url activity_url(activity, format: :json)
end
