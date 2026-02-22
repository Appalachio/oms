json.extract! org, :id, :org_uuid, :slug, :name, :subdomain, :domain, :color_scheme, :about, :logo, :archived_at, :created_at, :updated_at
json.url org_url(org, format: :json)
json.about org.about.to_s
json.logo url_for(org.logo)
