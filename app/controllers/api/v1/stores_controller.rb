class Api::V1::StoresController < ApiController
  include Api::V1::Concerns::Restfull

  before_action :load_publisher, only: :publisher_books
  before_action :load_record, only: [:show, :update, :destroy, :books_sold]

  def publisher_books
    @stores = Store.with_available_books_for_publisher(@publisher)
    respond_with @stores, each_serializer: StoreSerializer
  end

  def books_sold
    respond_with @record.books.sold, each_serializer: BookSerializer
  end

  private

  def permited_params
    params.require(:store).permit(:name)
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue  ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end
end
