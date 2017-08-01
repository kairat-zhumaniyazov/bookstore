# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:stocks).dependent(:destroy) }
  it { should have_many(:books).through(:stocks) }
end
