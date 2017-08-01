@publisher_1 = Publisher.create! name: Faker::Name.unique.name
@publisher_2 = Publisher.create! name: Faker::Name.unique.name
@publisher_3 = Publisher.create! name: Faker::Name.unique.name

@book_1 = Book.create! title: Faker::Book.title, publisher: @publisher_1
@book_2 = Book.create! title: Faker::Book.title, publisher: @publisher_1
@book_3 = Book.create! title: Faker::Book.title, publisher: @publisher_2

@store_1 = Store.create! name: Faker::Company.name
@store_2 = Store.create! name: Faker::Company.name
@store_3 = Store.create! name: Faker::Company.name

Stock.create! store: @store_1, book: @book_1, amount: 2
Stock.create! store: @store_2, book: @book_1, amount: 0
Stock.create! store: @store_3, book: @book_1, amount: 0

Stock.create! store: @store_1, book: @book_2, amount: 0
Stock.create! store: @store_2, book: @book_2, amount: 1
Stock.create! store: @store_3, book: @book_2, amount: 0

Stock.create! store: @store_1, book: @book_3, amount: 0
Stock.create! store: @store_2, book: @book_3, amount: 1
Stock.create! store: @store_3, book: @book_3, amount: 2
