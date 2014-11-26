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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :orgtree do
    parent 1
    title "MyString"
    description "MyText"
    image "MyString"
    phone "MyString"
    email "MyString"
    templateName "MyString"
    href "MyString"
    itemTitleColor "MyString"
    user_id 1
  end
end
