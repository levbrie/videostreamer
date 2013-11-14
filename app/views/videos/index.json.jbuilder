json.array!(@videos) do |video|
  json.extract! video, :url, :name
  json.url video_url(video, format: :json)
end
