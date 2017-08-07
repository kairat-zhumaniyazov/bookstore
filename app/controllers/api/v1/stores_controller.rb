class Api::V1::StoresController < ApiController
  include Api::V1::Concerns::Restfull

  before_action :load_publisher, only: [:publisher_books]
  before_action :load_record, only: [:show, :update, :destroy, :books_sold, :add_book]

  def publisher_books
    @stores = Store.with_available_books_for_publisher(@publisher)
    respond_with @stores, each_serializer: StoreSerializer
  end

  def books_sold
    respond_with @record.books.sold, each_serializer: BookSerializer
  end

  def add_book
    @record.add_stock(new_stock_params)
    respond_with :api, :v1, @record
  end

  private

  def permited_params
    params.require(:store).permit(:name)
  end

  def new_stock_params
    params.permit(:book_id, :amount)
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue  ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end
end
