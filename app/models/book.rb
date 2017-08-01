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
  has_many :stocks, dependent: :destroy
  has_many :stores, through: :stocks

  validates :title, presence: true

  scope :sold, -> { where('stocks.amount = 0') }
end
