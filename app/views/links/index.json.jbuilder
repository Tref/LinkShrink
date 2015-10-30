json.array!(@links) do |link|
  json.extract! link, :id, :full_url, :short_url, :access_count
  json.url link_url(link, format: :json)
end
