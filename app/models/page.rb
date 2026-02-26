class Page < ApplicationRecord
  belongs_to :user
  belongs_to :org
  has_rich_text :body
  has_many_attached :pictures
end
