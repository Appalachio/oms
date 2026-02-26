class CreatePages < ActiveRecord::Migration[8.1]
  def change
    create_table :pages do |t|
      t.uuid :page_uuid
      t.text :slug
      t.text :title
      t.text :subtitle
      t.enum :page_type
      t.jsonb :page_data
      t.datetime :published_at
      t.datetime :archived_at
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :org, null: false, foreign_key: true

      t.timestamps
    end
    add_index :pages, :page_uuid, unique: true
    add_index :pages, :slug, unique: true
    add_index :pages, :title, unique: true
  end
end
