shared_context 'books_and_stores' do
  let(:publisher) { create :publisher }
  let(:another_publisher) { create :publisher }

  let(:book_1) { create :book, publisher: publisher }
  let(:book_2) { create :book, publisher: publisher }
  let(:book_3) { create :book, publisher: another_publisher }

  let(:store_1) { create :store }
  let(:store_2) { create :store }
  let(:store_3) { create :store }

  before do
    Stock.create store: store_1, book: book_1, amount: 2
    Stock.create store: store_2, book: book_1, amount: 0
    Stock.create store: store_3, book: book_1, amount: 0

    Stock.create store: store_1, book: book_2, amount: 0
    Stock.create store: store_2, book: book_2, amount: 1
    Stock.create store: store_3, book: book_2, amount: 0

    Stock.create store: store_1, book: book_3, amount: 0
    Stock.create store: store_2, book: book_3, amount: 1
    Stock.create store: store_3, book: book_3, amount: 2
  end
end
