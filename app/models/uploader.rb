# == Schema Information
#
# Table name: uploaders
#
#  id           :integer          not null, primary key
#  file_name    :string(255)
#  content_type :string(255)
#  file_size    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author       :string(255)
#  user_id      :integer
#  attachment   :string(4000)
#  role_id      :integer
#  folder_id    :integer
#

class Uploader < ActiveRecord::Base
  attr_accessible :author, :attachment, :file_size, :content_type, :folder_id, :role_id
  belongs_to :user
  belongs_to :role
  belongs_to :folder
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :author, presence: true # Make sure the owner's name is present.
  validates :attachment, presence: true
  validates :folder, presence: true
end
