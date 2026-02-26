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
require "test_helper"

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
