# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  phone                  :string(255)
#  last_name              :string(4000)
#  profile_picture        :string(4000)
#  login                  :string(20)
#  pwd                    :string(20)
#  describe               :string(500)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :orgtree, :dependent => :destroy
  has_many :links, :dependent => :destroy
  has_many :uploaders
  has_many :folders
  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :orgtree, :links, :uploaders, :last_name, :profile_picture, :encrypted_password, :login
  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if self.roles.blank?
  end
end
