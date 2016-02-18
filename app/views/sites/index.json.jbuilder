json.array!(@sites) do |site|
  json.extract! site, :id, :name, :domain, :embed_code, :ph_network, :enabled
  json.url site_url(site, format: :json)
end
