class Api::V1::StoresController < ApiController
  before_action :load_publisher, only: :publisher_books
  before_action :load_store, only: [:show, :update, :destroy, :books_sold]

  def publisher_books
    @stores = Store.with_available_books_for_publisher(@publisher)
    respond_with @stores, each_serializer: StoreSerializer
  end

  def books_sold
    respond_with @store.books.sold, each_serializer: BookSerializer
  end

  def show
    respond_with @store
  end

  def index
    respond_with @stores = Store.all
  end

  def create
    respond_with :api, :v1, @store = Store.create(store_params)
  end

  def update
    @store.update_attributes(store_params)
    respond_with @store do |format|
      format.json { render json: StoreSerializer.new(@store), status: :ok }
    end
  end

  def destroy
    respond_with @store.destroy
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue  ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end

  def load_store
    @store = Store.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end
end
