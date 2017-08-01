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

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }

  it { should belong_to :publisher }
  it { should have_many(:stocks).dependent(:destroy) }
  it { should have_many(:stores).through(:stocks) }
end
