# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }
end
