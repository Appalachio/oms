class Org < ApplicationRecord
  has_rich_text :about
  has_one_attached :logo
end
