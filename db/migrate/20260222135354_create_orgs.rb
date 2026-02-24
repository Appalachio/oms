class CreateOrgs < ActiveRecord::Migration[8.1]
  def change
    create_enum :org_color_scheme,
        [ "default", "brite", "cerulean", "cosmo", "cyborg", "darkly", "flatly", "journal", "litera", "lumen", "lux", "materia", "minty", "morph", "pulse", "quartz", "sandstone", "simplex", "sketchy", "slate", "solar", "spacelab", "superhero", "united", "vapor", "yeti", "zephyr" ]

    create_table :orgs do |t|
      t.uuid :org_uuid, null: false
      t.text :slug, null: false

      t.text :name, null: false
      t.text :subdomain
      t.text :domain
      t.enum :color_scheme, enum_type: :org_color_scheme, default: "default", null: false

      t.datetime :archived_at
      t.timestamps
    end

    add_index :orgs, :org_uuid, unique: true
    add_index :orgs, :slug, unique: true
    add_index :orgs, :name, unique: true
  end
end
