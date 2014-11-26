# == Schema Information
#
# Table name: folders
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  role_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author      :string(4000)
#  parent_id   :integer
#  folder_path :string(4000)
#  description :string(4000)
#

class Folder < ActiveRecord::Base
  attr_accessible :description, :name, :author , :role_id
  belongs_to :role
  has_many :uploaders
  validates :name, :presence => true
end
