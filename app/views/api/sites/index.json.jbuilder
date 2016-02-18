json.array!(@api_sites) do |api_site|
  json.extract! api_site, :id
  json.url api_site_url(api_site, format: :json)
end
