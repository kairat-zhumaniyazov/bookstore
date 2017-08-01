# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Store < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :books, through: :stocks

  validates :name, presence: true

  scope :with_available_books, -> { joins(:stocks).where('stocks.amount > 0').uniq }
end
