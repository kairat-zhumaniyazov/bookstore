class Api::V1::PublisherBooksController < ApiController
  before_action :load_publisher

  def index
    respond_with @publisher.books
  end

  def show
    respond_with @publisher.books.where(id: params[:id]).first
  end

  def create
    respond_with :api, :v1, @book = @publisher.books.create(permited_params)
  end

  private

  def permited_params
    params.require(:book).permit(:title)
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end
end
