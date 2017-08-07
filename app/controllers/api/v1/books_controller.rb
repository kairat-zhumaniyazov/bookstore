class Api::V1::BooksController < ApiController
  include Api::V1::Concerns::Restfull

  before_action :load_publisher, only: [:create]

  def create
    @book = @publisher.books.create(permited_params)
    respond_with :api, :v1, @book
  end

  private

  def permited_params
    params.require(:book).permit(:title)
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e.to_s, status: :not_found
  end
end
