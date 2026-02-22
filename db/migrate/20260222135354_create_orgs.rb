class CreateOrgs < ActiveRecord::Migration[8.1]
  def change
    create_table :orgs do |t|
      t.uuid :org_uuid
      t.text :slug
      t.text :name
      t.text :subdomain
      t.text :domain
      t.enum :color_scheme
      t.datetime :archived_at

      t.timestamps
    end
    add_index :orgs, :org_uuid, unique: true
    add_index :orgs, :slug, unique: true
    add_index :orgs, :name, unique: true
  end
end
