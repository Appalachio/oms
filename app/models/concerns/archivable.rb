require "active_support/concern"

# Adds a "soft delete" option to models by archiving them.
module Archivable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(archived_at: nil) }
    scope :archived, -> { where.not(archived_at: nil) }
  end

  def archive
    update_attribute(:archived_at, Time.current)
  end

  def restore
    update_attribute(:archived_at, nil)
  end

  def archived?
    not self.archived_at.nil?
  end

  def active?
    self.archived_at.nil?
  end
end
