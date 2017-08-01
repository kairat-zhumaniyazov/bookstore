# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  store_id   :integer
#  book_id    :integer
#  amount     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :stock do
    
  end
end
