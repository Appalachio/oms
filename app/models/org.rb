# == Schema Information
#
# Table name: orgs
# Database name: primary
#
#  id           :bigint           not null, primary key
#  color_scheme :enum             default("default"), not null
#  domain       :text
#  name         :text             not null
#  org_uuid     :uuid             not null
#  slug         :text             not null
#  subdomain    :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  archived_at  :datetime
#
# Indexes
#
#  index_orgs_on_name      (name) UNIQUE
#  index_orgs_on_org_uuid  (org_uuid) UNIQUE
#  index_orgs_on_slug      (slug) UNIQUE
#
class Org < ApplicationRecord
  has_rich_text :about
  has_one_attached :logo do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [ 300, 300 ], preprocessed: true
  end

  enum :color_scheme, {
    default: "default", brite: "brite", cerulean: "cerulean", cosmo: "cosmo", cyborg: "cyborg", darkly: "darkly", flatly: "flatly", journal: "journal", litera: "litera", lumen: "lumen", lux: "lux", materia: "materia", minty: "minty", morph: "morph", pulse: "pulse", quartz: "quartz", sandstone: "sandstone", simplex: "simplex", sketchy: "sketchy", slate: "slate", solar: "solar", spacelab: "spacelab", superhero: "superhero", united: "united", vapor: "vapor", yeti: "yeti", zerphyr: "zephyr"
  }, prefix: true, default: :default, validate: true

  has_many :users
  has_many :pages

  validates :name, :about, :logo, :color_scheme, presence: true
  validates :name, uniqueness: true
  validate :logo_is_a_picture

  has_paper_trail
  include Archivable
  before_create :assign_org_uuid

  extend FriendlyId
  friendly_id :name

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  private

  def assign_org_uuid
    self.org_uuid = SecureRandom.uuid if self.org_uuid.blank?
  end

  def logo_is_a_picture
    if logo.attached? && !logo.content_type.in?(%w[image/png image/jpeg image/gif])
      errors.add(:logo, "must be in a photo format (png, jpeg, or gif)")
    end
  end
end
