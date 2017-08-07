class Api::V1::PublishersController < ApiController
  before_action :load_publisher, only: [:show, :update, :destroy]

  def show
    respond_with @publisher
  end

  def index
    respond_with Publisher.all
  end

  def create
    @publisher = Publisher.create(publisher_params)
    respond_with :api, :v1, @publisher
  end

  def update
    @publisher.update_attributes(publisher_params)
    respond_with @publisher do |format|
      format.json { render json: PublisherSerializer.new(@publisher), status: :ok }
    end
  end

  def destroy
    respond_with @publisher.destroy
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name)
  end

  def load_publisher
    @publisher = Publisher.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    respond_not_found(e)
  end
end
