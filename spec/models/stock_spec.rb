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

require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should belong_to :store }
  it { should belong_to :book }
  it { should validate_numericality_of :amount }
end
