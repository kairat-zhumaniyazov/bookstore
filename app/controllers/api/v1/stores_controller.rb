class Api::V1::StoresController < ApiController
  before_action :load_publisher, only: :publisher_books
  before_action :load_store, only: :books_sold

  respond_to :json

  def publisher_books
    @stores = Store.with_available_books_for_publisher(@publisher)
    respond_with @stores, each_serializer: StoresSerializer
  end

  def books_sold
    respond_with @store.books.sold, each_serializer: BookSerializer
  end

  def handle_not_found
    respond_with e.to_s, status: :not_found
  end

  private

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue  ActiveRecord::RecordNotFound => e
    respond_with e.to_s, status: :not_found
  end

  def load_store
    @store = Store.find(params[:id])
  end
end
