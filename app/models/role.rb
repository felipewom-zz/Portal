# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Role < ActiveRecord::Base
  scopify
  attr_accessible :name
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_many :uploaders
  has_many :folders
  belongs_to :resource, :polymorphic => true

end
