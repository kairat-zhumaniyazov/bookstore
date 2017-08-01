# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  publisher_id :integer
#

FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }

    publisher
  end
end
