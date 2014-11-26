# == Schema Information
#
# Table name: links
#
#  id      :integer          not null, primary key
#  url     :string(255)
#  name    :string(255)
#  user_id :integer
#  title   :string(4000)
#

class Link < ActiveRecord::Base
  attr_accessible :url, :name, :user_id
  belongs_to :user
end
