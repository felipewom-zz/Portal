# == Schema Information
#
# Table name: orgtrees
#
#  id             :integer          not null, primary key
#  parent         :string(255)
#  description    :string(255)
#  image          :string(255)
#  templateName   :string(255)
#  href           :string(255)
#  itemTitleColor :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  desc_job       :string(255)
#

require 'spec_helper'

describe Orgtree do
  pending "add some examples to (or delete) #{__FILE__}"
end
