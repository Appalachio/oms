class CreatePages < ActiveRecord::Migration[8.1]
  def change
    create_enum :page_page_type, [ "default" ]

    create_table :pages do |t|
      t.uuid :page_uuid, null: false
      t.text :slug, null: false

      t.text :title, null: false
      t.text :subtitle

      t.enum :page_type, enum_type: :page_page_type, default: "default", null: false
      t.jsonb :page_data, default: {}

      # t.belongs_to :user, null: false, foreign_key: true
      # t.belongs_to :org, null: false, foreign_key: true

      t.datetime :published_at
      t.datetime :archived_at
      t.timestamps
    end
    add_index :pages, :page_uuid, unique: true
    add_index :pages, :slug, unique: true
    add_index :pages, :title, unique: true
  end
end
