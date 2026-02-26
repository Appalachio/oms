json.extract! page, :id, :page_uuid, :slug, :title, :subtitle, :body, :page_type, :page_data, :pictures, :published_at, :archived_at, :user_id, :org_id, :created_at, :updated_at
json.url page_url(page, format: :json)
json.body page.body.to_s
json.pictures do
  json.array!(page.pictures) do |picture|
    json.id picture.id
    json.url url_for(picture)
  end
end
