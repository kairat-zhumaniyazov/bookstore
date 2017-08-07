class Api::V1::BooksController < ApiController
  before_action :load_record, only: [:show, :update, :destroy]
  before_action :load_publisher, only: [:create]
  before_action :load_list, only: [:index]

  def show
    respond_with @book
  end

  def index
    respond_with @books
  end

  def create
    @book = @publisher.books.create(book_params)
    respond_with :api, :v1, @book
  end

  def update
    @book.update_attributes(book_params)
    respond_with @book do |format|
      format.json { render json: BookSerializer.new(@book), status: :ok }
    end
  end

  def destroy
    respond_with @book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def load_record
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'record_not_found' }, status: :not_found
  end

  def load_publisher
    @publisher = Publisher.find(params[:publisher_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'publisher_not_found' }, status: :not_found
  end

  def load_list
    @books = Book.all
  end
end
