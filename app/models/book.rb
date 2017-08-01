# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ApplicationRecord
  validates :title, presence: true
end
