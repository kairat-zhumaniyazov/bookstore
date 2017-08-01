class Api::V1::PublishersController < ApiController
  before_action :load_publisher, only: :in_stores

  respond_to :json

  def in_stores
    @stores = Store.with_available_books_for_publisher(@publisher)
    respond_with @stores, each_serializer: StoresSerializer
  end

  private

  def load_publisher
    @publisher = Publisher.find(params[:id])
  end
end
