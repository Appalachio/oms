# == Schema Information
#
# Table name: pages
# Database name: primary
#
#  id           :bigint           not null, primary key
#  page_data    :jsonb
#  page_type    :enum             default("default"), not null
#  page_uuid    :uuid             not null
#  published_at :datetime
#  slug         :text             not null
#  subtitle     :text
#  title        :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  archived_at  :datetime
#
# Indexes
#
#  index_pages_on_page_uuid  (page_uuid) UNIQUE
#  index_pages_on_slug       (slug) UNIQUE
#  index_pages_on_title      (title) UNIQUE
#
class Page < ApplicationRecord
  has_rich_text :body
  has_many_attached :pictures

  enum :page_type, { default: "default" }, prefix: true, default: :default, validate: true

  # belongs_to :user
  # belongs_to :org

  validates :title, :body, :page_type, presence: true
  validates :title, uniqueness: true
  validate :pictures_are_pictures

  has_paper_trail
  include Archivable
  before_create :assign_page_uuid

  extend FriendlyId
  friendly_id :title

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  private

  def assign_page_uuid
    self.page_uuid = SecureRandom.uuid if self.page_uuid.blank?
  end

  def pictures_are_pictures
    if pictures.attached?
      pictures.each do |picture|
        if !picture.content_type.in?(%w[image/png image/jpeg image/gif])
          errors.add(:pictures, "all pictures must be in a photo format (png, jpeg, or gif)")
        end
      end
    end
  end
end
