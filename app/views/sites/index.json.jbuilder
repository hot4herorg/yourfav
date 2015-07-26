json.array!(@sites) do |site|
  json.extract! site, :id, :name, :domain, :embed_code, :login_address, :login_method, :ph_network, :enabled
  json.url site_url(site, format: :json)
end
