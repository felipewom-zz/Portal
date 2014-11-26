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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder do
    name "MyString"
    description "MyText"
    role "MyString"
    created_at "MyString"
    updated_at "MyString"
  end
end
