class Api::V1::StoresController < ApiController
  before_action :load_store, only: :books_sold

  respond_to :json

  def books_sold
    respond_with @store.books.sold, each_serializer: BookSerializer
  end

  private

  def load_store
    @store = Store.find(params[:id])
  end
end
