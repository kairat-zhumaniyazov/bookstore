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

  scope :with_available_books_for_publisher, -> (publisher) {
    joins(
      'INNER JOIN stocks ON stocks.store_id = stores.id AND stocks.amount > 0',
      "INNER JOIN books ON books.id = stocks.book_id AND books.publisher_id = #{publisher.id}"
    )
  }

  def add_stock(params)
    book = Book.find(params[:book_id]) rescue nil
    stocks.create(book_id: book.id, amount: params[:amount]) if book.present?
  end
end
