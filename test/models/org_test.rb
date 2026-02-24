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
require "test_helper"

class OrgTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
