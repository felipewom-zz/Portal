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

#

class Orgtree < ActiveRecord::Base
  attr_accessible :description, :email, :href, :image, :itemTitleColor, :parent, :phone,
                  :desc_job, :templateName, :title, :user, :user_id
  belongs_to :user
  after_initialize :init
  def init #will set the default value only if it's nil
    self.templateName   ||= "contactTemplate"
    self.image          ||= "/assets/c.png"
    self.itemTitleColor ||= "primitives.common.Colors.Black"
  end
end
