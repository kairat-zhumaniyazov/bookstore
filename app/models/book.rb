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

class Book < ApplicationRecord
  belongs_to :publisher

  validates :title, presence: true
end
